class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :post
      t.string :notification
      t.timestamps
    end
  end
end
