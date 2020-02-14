class AddColumnsToHotel < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :rating, :float
    add_column :hotels, :currency, :string
    add_column :hotels, :description, :string
  end
end
