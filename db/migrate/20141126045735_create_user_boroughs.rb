class CreateUserBoroughs < ActiveRecord::Migration
  def change
    create_table :user_boroughs do |t|
      t.integer :user_id
      t.integer :borough_id
      t.timestamps
    end
  end
end
