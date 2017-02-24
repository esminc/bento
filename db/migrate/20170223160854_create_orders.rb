class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.date :date, null: false
      t.datetime :closed_at

      t.timestamps
    end
  end
end
