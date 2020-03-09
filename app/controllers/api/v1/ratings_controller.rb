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

    ratings = Rating.create(trip_id: params[:trip], user_id: current_user.id,
                            destination_rating: params[:destination_rating],
                            activities_rating: params[:activities_rating],
                            restaurants_rating: params[:restaurants_rating],
                            hotel_rating: params[:hotel_rating])
    if ratings.persisted?
      render json: ratings, status: 200
    else
      render json: { error: ratings.errors.full_messages }, status: 422
    end
  end

  def show
    ratings = Rating.where(trip_id: params[:id])

    render json: ratings[0]
  end

  def update
    :authenticate_user!

    rating_to_update = Rating.where(trip_id: params[:id])

    if rating_to_update[0].user_id != current_user.id
      render json: { error: 'Only authorized to update own ratings' }, status: 401
      return
    end

    rating_to_update.update(update_params)

    render json: rating_to_update[0], status: 200
  end

  private

  def update_params
    params.permit(:destination_rating, :activities_rating, :restaurants_rating, :hotel_rating).reject { |_k, v| v.nil? }
  end
end
