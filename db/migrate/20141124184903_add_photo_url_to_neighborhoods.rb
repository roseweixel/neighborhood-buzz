class AddPhotoUrlToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :photo_url, :string
  end
end
