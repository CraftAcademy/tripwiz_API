class Rating < ApplicationRecord
  validates_presence_of :trip_id, :user_id

  belongs_to :trip
end
