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

ActiveRecord::Schema.define(version: 2021_05_01_051601) do

  create_table "roles", charset: "utf8mb4", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.integer "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.boolean "enabled", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "statuses", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.integer "hp", null: false
    t.integer "mp", null: false
    t.integer "attack", null: false
    t.integer "defence", null: false
    t.integer "next_level_point", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_statuses_on_role_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest", null: false
    t.timestamp "delete_date"
    t.integer "stage_level", null: false
  end

  add_foreign_key "statuses", "roles"
end
