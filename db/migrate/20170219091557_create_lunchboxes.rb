class CreateLunchboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :lunchboxes do |t|
      t.string :name, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
