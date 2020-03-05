# frozen_string_literal: true

class Api::V1::RatingsController < ApplicationController
  def create
    :authenticate_user!

    trip_previous_ratings = Rating.where(trip_id: params[:trip])

    trip_previous_ratings.each do |trip|
      if trip.user_id == current_user.id
        render json: { error: 'Trip already rated, please update' }, status: 403
        return
      end
    end

    rating = Rating.create(trip_id: params[:trip], user_id: current_user.id,
                           destination_rating: params[:destination_rating],
                           activities_rating: params[:activities_rating],
                           restaurants_rating: params[:restaurants_rating],
                           hotel_rating: params[:hotel_rating])
    if rating.persisted?
      render json: rating, status: 200
    else
      render json: { error: rating.errors.full_messages }, status: 422
    end
  end

  def show
    ratings = Rating.where(trip_id: params[:id])

    render json: ratings[0]
  end

end
