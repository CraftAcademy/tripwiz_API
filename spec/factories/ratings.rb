# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    trip_id { 5 }
    user_id { 5 }
    rating { 4 }
  end
end
