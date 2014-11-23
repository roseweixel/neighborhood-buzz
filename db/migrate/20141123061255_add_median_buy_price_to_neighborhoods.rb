class AddMedianBuyPriceToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :median_buy_price, :integer
  end
end
