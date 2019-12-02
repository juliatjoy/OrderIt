class CreateMenu < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.integer :menu_type
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
