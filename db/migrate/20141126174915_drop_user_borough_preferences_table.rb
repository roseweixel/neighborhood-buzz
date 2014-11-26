class DropUserBoroughPreferencesTable < ActiveRecord::Migration
  def change
    drop_table :user_borough_preferences
  end
end
