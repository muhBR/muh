class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :item_type, null: false
      t.string :description, null: false
      t.decimal :purchase_price, null: false
      t.decimal :sale_price, null: false
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.integer :category_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
    add_index 'items', ['user_id', 'name'], unique: true
  end
end
