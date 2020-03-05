class AddTripIdToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :trip_id, :integer
    add_column :ratings, :user_id, :integer
    add_column :ratings, :destination_rating, :integer
    add_column :ratings, :activities_rating, :integer
    add_column :ratings, :restaurants_rating, :integer
    add_column :ratings, :hotel_rating, :integer
  end
end
