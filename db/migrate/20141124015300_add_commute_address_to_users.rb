class AddCommuteAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commute_address, :string
  end
end
