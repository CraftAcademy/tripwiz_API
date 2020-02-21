# frozen_string_literal: true

class Api::V1::ActivityTypesController < ApplicationController

  include ActivityCreator

  def create
    activity_type = create_activity_type
    activity_visits = set_activity_visits
    search_keyword = params[:keyword]

    activities = create_activities(activity_type, activity_visits, search_keyword)

    if activities && activities.length == activity_visits.to_i
      render json: activities, status: 200
    else
      activity_type.destroy
      render json: { error: 'Failed to create activity.' }, status: 422
    end
  end

  def index
    if params[:activity_type] == 'restaurant'
      activity_types = ActivityType.where(trip_id: params[:trip], activity_type: params[:activity_type])
    else
      activity_types = ActivityType.where(trip_id: params[:trip])
    end
    activities = {}
    activity_types.each do |type|
      activities[type.activity_type] = Activity.where(activity_type_id: type)
    end
    render json: activities, status: 200
  end

  def destroy
    if params[:activity_type]
      activity_type_to_destroy = ActivityType.find_by(trip_id: params[:trip], activity_type: params[:activity_type])
    else
      activity_type_to_destroy = ActivityType.find_by(trip_id: params[:trip])
    end
    activities_to_destroy = Activity.where(activity_type_id: activity_type_to_destroy)
    ActivityType.destroy(activity_type_to_destroy.id)
    Activity.destroy(activities_to_destroy.ids)
    render head: :ok
  end

  private

  def set_activity_visits
    if params[:activity_type] == 'restaurant'
      if params[:additional_activity]
        Trip.find(params[:trip]).days / 2
      else
        Trip.find(params[:trip]).days
      end
    else
      params[:activity_visits]
    end
  end

  def create_activity_type
    if params[:additional_activity]
      activity_type = ActivityType.find_by(trip_id: params[:trip], activity_type: params[:activity_type])
      activity_type
    else
      activity_type = ActivityType.create(activity_type: params.require(:activity_type),
                                          trip_id: params.require(:trip),
                                          max_price: params[:max_price])
      if activity_type.persisted?
        activity_type
      else
        render json: { error: activity_type.errors.full_messages }, status: 422
      end
    end
  end
end
