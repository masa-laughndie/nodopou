# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180503085632) do

  create_table "contacts", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "email", limit: 255, null: false
    t.text "content", limit: 2000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "content", null: false
    t.integer "user_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "mylists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "list_id", null: false
    t.boolean "active", default: true, null: false
    t.boolean "check", default: false, null: false
    t.integer "check_count", default: 0, null: false
    t.integer "running_days", default: 0, null: false
    t.integer "max_running_days", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_mylists_on_list_id"
    t.index ["user_id", "list_id"], name: "index_mylists_on_user_id_and_list_id", unique: true
    t.index ["user_id"], name: "index_mylists_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "picture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "email", limit: 255, null: false
    t.boolean "is_send_email", default: false, null: false
    t.string "account_id", limit: 15, null: false
    t.string "image"
    t.string "profile"
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false, null: false
    t.string "uid"
    t.string "provider"
    t.string "t_token"
    t.string "t_secret"
    t.string "reset_digest"
    t.string "e_token"
    t.datetime "reset_sent_at"
    t.integer "check_reset_time", default: 6, null: false
    t.datetime "check_reset_at", default: "2018-05-11 21:00:00", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
