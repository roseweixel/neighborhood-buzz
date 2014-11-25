class AddCommuteCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commute_city, :string
  end
end
