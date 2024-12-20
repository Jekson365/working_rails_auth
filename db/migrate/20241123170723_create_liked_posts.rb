class CreateLikedPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :liked_posts do |t|
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
