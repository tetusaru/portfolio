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

ActiveRecord::Schema[8.0].define(version: 2025_04_05_120000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.string "answer_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "diagnosis_id", null: false
    t.index ["diagnosis_id"], name: "index_answers_on_diagnosis_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.bigint "user_id"
    t.text "questions"
    t.string "answers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diagnoses_on_user_id"
  end

  create_table "diagnosis_recommendations", force: :cascade do |t|
    t.bigint "diagnosis_id", null: false
    t.bigint "sauna_facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnosis_id"], name: "index_diagnosis_recommendations_on_diagnosis_id"
    t.index ["sauna_facility_id"], name: "index_diagnosis_recommendations_on_sauna_facility_id"
  end

  create_table "diagnosis_results", force: :cascade do |t|
    t.bigint "diagnosis_id", null: false
    t.text "recommendation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnosis_id"], name: "index_diagnosis_results_on_diagnosis_id"
  end

  create_table "mysaunas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "sauna_name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_posted_at"
    t.index ["user_id"], name: "index_mysaunas_on_user_id", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mysauna_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sauna_name"
    t.text "comment"
    t.index ["mysauna_id"], name: "index_posts_on_mysauna_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sauna_facilities", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hot_sauna", default: false, null: false
    t.boolean "outdoor_bath", default: false, null: false
    t.boolean "cold_bath", default: false, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "temperature_level"
    t.string "facility_type"
    t.string "atmosphere"
  end

  create_table "solid_queue_assignments", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "thread_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_solid_queue_assignments_on_job_id"
    t.index ["thread_id"], name: "index_solid_queue_assignments_on_thread_id"
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "job_class", null: false
    t.datetime "scheduled_at"
    t.jsonb "arguments", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solid_queue_threads", force: :cascade do |t|
    t.bigint "process_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["process_id"], name: "index_solid_queue_threads_on_process_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "crypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "diagnoses"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "diagnoses", "users"
  add_foreign_key "diagnosis_recommendations", "diagnoses"
  add_foreign_key "diagnosis_recommendations", "sauna_facilities"
  add_foreign_key "diagnosis_results", "diagnoses"
  add_foreign_key "mysaunas", "users"
  add_foreign_key "posts", "mysaunas"
  add_foreign_key "posts", "users"
  add_foreign_key "solid_queue_assignments", "solid_queue_jobs", column: "job_id"
  add_foreign_key "solid_queue_assignments", "solid_queue_threads", column: "thread_id"
  add_foreign_key "solid_queue_threads", "solid_queue_processes", column: "process_id"
end
