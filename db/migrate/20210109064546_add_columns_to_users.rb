class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :zipcode, :string
    add_column :users, :address, :string
    add_column :users, :address_city, :string
    add_column :users, :address_street, :string
    add_column :users, :address_building, :string
  end
end
