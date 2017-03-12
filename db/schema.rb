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

ActiveRecord::Schema.define(version: 20170311124226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["access_token"], name: "index_app_keys_on_access_token", using: :btree
  end

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "template_id"
    t.boolean  "draft"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["template_id"], name: "index_cards_on_template_id", using: :btree
    t.index ["title"], name: "index_cards_on_title", using: :btree
    t.index ["user_id"], name: "index_cards_on_user_id", using: :btree
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_templates_on_name", using: :btree
  end

  create_table "textual_contents", force: :cascade do |t|
    t.text     "content"
    t.integer  "x_position"
    t.integer  "y_position"
    t.string   "font_family"
    t.string   "font_size"
    t.string   "color"
    t.integer  "card_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "width"
    t.integer  "height"
    t.index ["card_id"], name: "index_textual_contents_on_card_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "email"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "cards", "templates"
  add_foreign_key "cards", "users"
  add_foreign_key "textual_contents", "cards"
end
