class AddTripIdToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :trip_id, :integer
    add_column :ratings, :user_id, :integer
    add_column :ratings, :rating, :integer
  end
end
