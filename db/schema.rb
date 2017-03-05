ActiveRecord::Schema.define(version: 20170223160854) do

  enable_extension "plpgsql"

  create_table "lunchboxes", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",      null: false
    t.integer  "lunchbox_id",   null: false
    t.string   "customer_name", null: false
    t.datetime "received_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.date     "date",       null: false
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
