class RefactorPasswordFieldsForUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password
    remove_column :users, :password_confirm
    add_column    :users, :password_digest, :string
  end

  def down
    add_column :users, :password, :string
    add_column :users, :password_confirm, :string
    remove_column :users, :password_digest
  end
end
