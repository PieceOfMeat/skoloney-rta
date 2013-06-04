class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :full_name
      t.date :birthday
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :password
      t.string :password_confirm

      t.timestamps
    end
  end
end
