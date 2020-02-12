# frozen_string_literal: true

class Api::V1::TripsController < ApplicationController
  def create
    destination = get_destination(params)
    trip = Trip.create(destination: destination,
                       lat: params[:lat],
                       lng: params[:lng],
                       days: params[:days])

    if trip.persisted?
      render json: trip
    else
      render json: { error: trip.errors.full_messages }, status: 422
    end
  end

  def show
    trip = Trip.find(params[:id])
    activities = {}
    trip.activity_types.each do |type|
      activities[type.activity_type] = Activity.where(activity_type_id: type)
    end
    hotels = Hotel.where(trip_id: params[:id])

    response = { trip: trip, activity: activities, hotels: hotels }
    render json: response
  end

  def destroy
    trip_to_destroy = Trip.find(params[:trip])
    Trip.destroy(trip_to_destroy.id)
    render head: :ok
  end

  private

  def get_destination(params)
    response = JSON.parse RestClient.get "http://gd.geobytes.com/GetNearbyCities?radius='1500'&Latitude=#{params[:lat]}&Longitude=#{params[:lng]}&limit=1"
    destination = response[0][1]
  end
end
