# frozen_string_literal: true

class Api::V1::TripsController < ApplicationController
  def create
    :authenticate_user!
    destination = get_destination(params)
    if destination == 'N/A'
      destination = params[:lat][0, 5] + ',' + params[:lng][0, 5]
    end
    trip = Trip.create(destination: destination,
                       lat: params[:lat],
                       lng: params[:lng],
                       days: params[:days],
                       user_id: current_user.id)

    if trip.persisted?
      render json: trip
    else
      render json: { error: trip.errors.full_messages }, status: 422
    end
  end

  def show
    trip = Trip.find(params[:id])
    image = get_trip_image(trip.destination)
    activities = {}
    trip.activity_types.each do |type|
      activities[type.activity_type] = Activity.where(activity_type_id: type)
    end
    hotels = Hotel.where(trip_id: params[:id])

    response = { trip: trip, activity: activities, hotels: hotels, image: image }
    render json: response
  end

  def destroy
    Hotel.where(trip_id: params[:trip]).destroy_all
    ActivityType.where(trip_id: params[:trip]).destroy_all
    trip_to_destroy = Trip.find(params[:trip])
    Trip.destroy(trip_to_destroy.id)
    render head: :ok
  end

  def index
    trips_to_display = []

    if current_user
      trips = Trip.where(user_id: current_user.id)
      trips.each do |trip|
        trips_to_display << trip unless trip.hotels.empty?
      end
    else
      trips = Trip.all
      trips.each do |trip|
        trips_to_display << trip unless trip.hotels.empty?
      end
    end
    render json: trips_to_display.last(5)
  end

  private

  def get_destination(params)
    response = JSON.parse RestClient::Request.execute(method: :get, url: "http://gd.geobytes.com/GetNearbyCities?radius='1500'&Latitude=#{params[:lat]}&Longitude=#{params[:lng]}&limit=1", open_timeout: 4, timeout: 4)
    destination = response[0][1]
  rescue RestClient::ExceptionWithResponse => e
    destination = 'N/A'
  end

  def get_trip_image(destination)
    params = { input: destination,
               inputtype: 'textquery',
               fields: 'photos',
               types: 'locality',
               key: Rails.application.credentials.google_api_token }
    url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?'
    response = JSON.parse RestClient.get url, params: params.compact
    response['candidates'][0]['photos'][0]['photo_reference']
  end
end
