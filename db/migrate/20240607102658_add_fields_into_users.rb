class AddFieldsIntoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :type, :string
    add_column :users, :gender, :integer
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
  end
end
