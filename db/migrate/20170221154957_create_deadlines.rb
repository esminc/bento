class CreateDeadlines < ActiveRecord::Migration[5.0]
  def change
    create_table :deadlines do |t|
      t.date :orderd_on
      t.datetime :closet_at

      t.timestamps
    end
  end
end
