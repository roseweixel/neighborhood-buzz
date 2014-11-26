class AddBoroughIdToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :borough_id, :integer
  end
end
