class AddConnectionsTable < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :category_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
