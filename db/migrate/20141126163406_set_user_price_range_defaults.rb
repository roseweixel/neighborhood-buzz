class SetUserPriceRangeDefaults < ActiveRecord::Migration
  def change
    change_column :users, :min_rent_price, :integer, :default => 0
    change_column :users, :max_rent_price, :integer, :default => 10000000
    change_column :users, :min_buy_price, :integer, :default => 0
    change_column :users, :max_buy_price, :integer, :default => 10000000
  end
end
