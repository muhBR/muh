class CreateItemServiceOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :item_service_orders do |t|
      t.integer :service_order_id, null: false, index: true, foreign_key: true
      t.integer :item_id, null: false, index: true, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :purchase_price, null: false
      t.decimal :sale_price, null: false

      t.timestamps
    end
  end
end
