class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.bigint :phone
      t.bigint :user_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
    add_index 'customers', ['user_id', 'name'], unique: true
    add_index 'customers', ['user_id', 'email'], unique: true
    add_index 'customers', ['user_id', 'phone'], unique: true
  end
end
