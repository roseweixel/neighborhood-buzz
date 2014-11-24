class AddMedianBuyPriceStringToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :median_buy_price_string, :string
  end
end
