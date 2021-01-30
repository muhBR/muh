class CreateServiceOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :service_orders do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.integer :customer_id, null: false, index: true, foreign_key: true

      t.string :name, null: false
      t.string :status, null: false
      t.string :extra_information

      t.date :accomplishment_date
      t.date :delivery_date

      t.decimal :discount

      t.timestamps
    end
  end
end
