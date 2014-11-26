class RemoveBoroughAttributeFromNeighborhoods < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :borough, :string
  end
end
