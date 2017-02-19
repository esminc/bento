class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|

      t.integer :lunckbox_id
      t.string :customer_name
      t.date :orderd_on

      t.timestamps
    end
  end
end
