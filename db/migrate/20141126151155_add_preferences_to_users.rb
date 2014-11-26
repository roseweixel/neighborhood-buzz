class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :want_to_rent, :boolean
    add_column :users, :want_to_buy, :boolean
    add_column :users, :min_rent_price, :integer
    add_column :users, :max_rent_price, :integer
    add_column :users, :min_buy_price, :integer
    add_column :users, :max_buy_price, :integer
  end
end
