# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    trip_id { 5 }
    user_id { 5 }
    destination_rating { 4 }
    activities_rating { 4 }
    restaurants_rating { 4 }
    hotel_rating { 4 }
  end
end
