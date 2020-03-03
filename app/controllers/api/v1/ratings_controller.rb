class Api::V1::RatingsController < ApplicationController

  def create
    :authenticate_user!
    rating = Rating.create(trip_id: params[:trip], user_id: current_user.id, rating: params[:rating])
    if rating.persisted?
      render json: rating, status: 200
    else
      render json: { error: rating.errors.full_messages }, status: 422
    end
  end

end
