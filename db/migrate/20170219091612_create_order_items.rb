class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.integer :lunckbox_id
      t.string :customer_name
      t.text :memo
      t.datetime :received_at

      t.timestamps
    end
  end
end
