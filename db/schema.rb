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

ActiveRecord::Schema[7.1].define(version: 2025_02_23_085150) do
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

  create_table "articles", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "business_name"
    t.string "website_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_ideas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "suggestions"
  end

  create_table "ideas", force: :cascade do |t|
    t.date "due_date"
    t.integer "priority"
    t.string "action_point"
    t.integer "status"
    t.boolean "added_to_business_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pestel_analyses", force: :cascade do |t|
    t.integer "business_idea_id", null: false
    t.text "political"
    t.text "economic"
    t.text "social"
    t.text "technological"
    t.text "environmental"
    t.text "legal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_pestel_analyses_on_business_idea_id"
  end

  create_table "swot_analyses", force: :cascade do |t|
    t.integer "business_idea_id", null: false
    t.text "strengths"
    t.text "weaknesses"
    t.text "opportunities"
    t.text "threats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_swot_analyses_on_business_idea_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "pestel_analyses", "business_ideas"
  add_foreign_key "swot_analyses", "business_ideas"
end
