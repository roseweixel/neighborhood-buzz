class RenameUserBoroughsToUserBoroughPreferences < ActiveRecord::Migration
  def change
    rename_table :user_boroughs, :user_borough_preferences
  end
end
