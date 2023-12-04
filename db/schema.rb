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

ActiveRecord::Schema[7.1].define(version: 2023_12_04_104708) do
  create_table "banners", force: :cascade do |t|
    t.string "image"
    t.string "url"
    t.integer "sorting", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "level", default: 1
    t.string "path"
    t.string "name"
    t.string "key"
    t.string "description"
    t.string "image"
    t.string "url"
    t.string "type"
    t.integer "sorting", default: 1
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_links", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "sorting", default: 1
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "desc"
    t.text "content"
    t.string "image"
    t.string "display_title"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "logo"
    t.string "ico"
    t.text "copyright"
    t.string "email"
    t.string "skype"
    t.string "whatsapp"
    t.string "phone"
    t.integer "product_per_page"
    t.integer "post_per_page"
    t.integer "recommend_per_page"
    t.text "share_code"
    t.string "email_user_name"
    t.string "email_password"
    t.string "email_port"
    t.string "email_smtp"
    t.string "email_receiver"
    t.string "email_sender"
    t.boolean "email_active", default: false
    t.text "ga_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "new_arrive_per_page"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
