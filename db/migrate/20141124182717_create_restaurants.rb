class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :neighborhood_id
      t.string :name
      t.string :url
      t.string :stars_img
      t.string :address
      t.timestamps
    end
  end
end
