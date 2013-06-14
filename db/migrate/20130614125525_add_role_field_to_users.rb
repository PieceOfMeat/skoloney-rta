class AddRoleFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => User::COMMON_ROLE
  end
end
