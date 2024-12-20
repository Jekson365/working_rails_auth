class AddColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts,:camera,:string
    add_column :posts,:model,:string
    add_column :posts,:image_location,:string
  end
end
