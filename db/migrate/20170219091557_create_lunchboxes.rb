class CreateLunchboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :lunchboxes do |t|

      t.timestamps
    end
  end
end
