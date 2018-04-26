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

ActiveRecord::Schema.define(version: 20180425164427) do

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer "user_id"
    t.string "content"
    t.integer "user_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "mylists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.boolean "active", default: true
    t.boolean "check", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_mylists_on_list_id"
    t.index ["user_id", "list_id"], name: "index_mylists_on_user_id_and_list_id", unique: true
    t.index ["user_id"], name: "index_mylists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "is_send_email", default: false
    t.string "account_id"
    t.string "image"
    t.string "profile"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "uid"
    t.string "provider"
    t.string "reset_digest"
    t.string "e_token"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
