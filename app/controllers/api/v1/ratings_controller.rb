# frozen_string_literal: true

class Api::V1::RatingsController < ApplicationController
  def create
    :authenticate_user!


    trips_to_rate = Rating.where(trip_id: params[:trip])
    trips_to_rate.each do |trip|
      if trip.user_id == current_user.id
        render json: { error: 'Trip already rated by this' }, status: 403
        return
      end
    end

    if params
      rating = Rating.create(trip_id: params[:trip], user_id: current_user.id, rating: params[:rating])
      if rating.persisted?
        render json: rating, status: 200
      else
        render json: { error: rating.errors.full_messages }, status: 422
      end
    end
end
end
