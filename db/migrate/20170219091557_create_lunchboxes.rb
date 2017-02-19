class CreateLunchboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :lunchboxes do |t|

      t.integer :type
      t.integer :price

      t.timestamps
    end
  end
end
