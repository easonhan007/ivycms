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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_123330) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.text "content"
  end

  create_table "download_files", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sorting", default: 1
  end

  create_table "friend_links", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "sorting", default: 1
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alt"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "content"
    t.string "ip"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "navigations", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.boolean "dropdown", default: false
    t.integer "sorting", default: 1
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
    t.boolean "is_md", default: false
    t.text "md_content"
    t.boolean "is_draft", default: false
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "meta_title"
    t.string "name"
    t.string "key"
    t.string "desc"
    t.text "specs"
    t.string "model_string"
    t.text "content"
    t.string "price"
    t.string "url"
    t.boolean "new_arrive", default: true
    t.integer "sorting", default: 1
    t.boolean "hot", default: true
    t.boolean "active", default: true
    t.boolean "recommend", default: true
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "images"
    t.index ["category_id"], name: "index_products_on_category_id"
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
    t.string "email_passwd"
    t.string "email_port"
    t.string "email_smtp"
    t.string "email_receiver"
    t.string "email_sender"
    t.boolean "email_active", default: false
    t.text "ga_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "new_arrive_per_page"
    t.boolean "email_auto_ssl", default: true
    t.boolean "email_authentication", default: true
    t.string "seo_meta_title"
    t.string "seo_keywords"
    t.string "seo_description"
    t.string "theme"
    t.text "raw_block"
    t.string "cf_site_key"
    t.string "cf_secret_key"
    t.text "tawk_code"
    t.text "g_tag_head"
    t.text "g_tag_body"
    t.integer "latest_post_count", default: 3
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
