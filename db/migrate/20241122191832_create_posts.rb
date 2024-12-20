class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :image
      t.references :user
      t.timestamps
    end
  end
end
