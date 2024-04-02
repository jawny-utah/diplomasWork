# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_02_192021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price_per_square_meter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.string "description", null: false
    t.string "link_to", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "wear_id"
    t.integer "quantity", null: false
    t.integer "status", default: 0
    t.integer "payment_type", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["wear_id"], name: "index_orders_on_wear_id"
  end

  create_table "shipment_orders", force: :cascade do |t|
    t.bigint "order_id"
    t.string "shipment_type"
    t.string "description"
    t.integer "delivery_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shipment_orders_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.integer "role", default: 0
    t.string "address"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wear_categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wears", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.decimal "price", null: false
    t.string "brand"
    t.string "color"
    t.integer "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
