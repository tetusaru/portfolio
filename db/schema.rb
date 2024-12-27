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

ActiveRecord::Schema[8.0].define(version: 2024_12_26_014213) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.string "answer_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.bigint "user_id", null: false
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
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "diagnoses", "users"
  add_foreign_key "diagnosis_recommendations", "diagnoses"
  add_foreign_key "diagnosis_recommendations", "sauna_facilities"
  add_foreign_key "diagnosis_results", "diagnoses"
end
