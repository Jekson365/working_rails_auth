class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users,:profession,:string
    add_column :users,:city,:string
  end
end
