# frozen_string_literal: true

class Api::V1::TripsController < ApplicationController

  def create
    :authenticate_user!
    destination = get_destination(params)
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
    trip_to_destroy = Trip.find(params[:trip])
    Trip.destroy(trip_to_destroy.id)
    render head: :ok
  end

  def index
    trips = Trip.last(5)
    render json: trips
  end

  private

  def get_destination(params)
    response = JSON.parse RestClient.get "http://gd.geobytes.com/GetNearbyCities?radius='1500'&Latitude=#{params[:lat]}&Longitude=#{params[:lng]}&limit=1"
    destination = response[0][1]
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
