class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :advertisements, :user_id
    add_index :advertisements, :created_at
  end
end