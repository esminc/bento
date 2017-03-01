class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false
      t.integer :lunchbox_id, null: false
      t.string :customer_name, null: false
      t.datetime :received_at

      t.timestamps
    end
  end
end
