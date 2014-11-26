class SetUserBooleanDefaults < ActiveRecord::Migration
  def change
    change_column :users, :want_to_rent, :boolean, :default => true
    change_column :users, :want_to_buy, :boolean, :default => true
  end
end
