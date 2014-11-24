class AddStreeteasyColumnsToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :median_rental_price, :string
    add_column :neighborhoods, :median_rental_price_integer, :integer
    add_column :neighborhoods, :noko_search_url, :string
    add_column :neighborhoods, :noko_img_url_1, :string
    add_column :neighborhoods, :noko_img_url_2, :string
    add_column :neighborhoods, :noko_img_url_3, :string
    add_column :neighborhoods, :noko_listing_url_1, :string
    add_column :neighborhoods, :noko_listing_url_2, :string
    add_column :neighborhoods, :noko_listing_url_3, :string
    add_column :neighborhoods, :noko_monthly_rent_1, :string
    add_column :neighborhoods, :noko_monthly_rent_2, :string
    add_column :neighborhoods, :noko_monthly_rent_3, :string
  end
end
