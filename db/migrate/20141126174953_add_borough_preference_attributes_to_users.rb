class AddBoroughPreferenceAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes_manhattan, :boolean, :default => true
    add_column :users, :likes_brooklyn, :boolean, :default => true
    add_column :users, :likes_queens, :boolean, :default => true
  end
end
