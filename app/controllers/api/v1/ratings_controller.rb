# frozen_string_literal: true

class Api::V1::RatingsController < ApplicationController
  def create
    :authenticate_user!

    if params[:destination_rating] || params[:activities_rating] || params[:restaurants_rating] || params[:hotel_rating]
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
  end
end
