class CreateLunchboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :lunchboxes do |t|

      t.integer :type, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
