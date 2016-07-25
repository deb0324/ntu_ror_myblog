class AddFramesTable < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.string :name
      t.string :image
      t.integer :gallery_id

      t.timestamps null: false
    end
  end
end
