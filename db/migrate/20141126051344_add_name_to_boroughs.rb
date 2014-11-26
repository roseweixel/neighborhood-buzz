class AddNameToBoroughs < ActiveRecord::Migration
  def change
    add_column :boroughs, :name, :string
  end
end
