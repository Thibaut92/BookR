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

ActiveRecord::Schema[8.0].define(version: 2024_12_06_225000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "meetings", force: :cascade do |t|
    t.bigint "industrial_id", null: false
    t.bigint "project_manager_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.text "notes"
    t.string "location"
    t.string "meeting_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industrial_id"], name: "index_meetings_on_industrial_id"
    t.index ["project_manager_id"], name: "index_meetings_on_project_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "company_name"
    t.string "siret"
    t.string "phone"
    t.integer "account_type"
    t.string "business_subcategory"
    t.string "company_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["siret"], name: "index_users_on_siret", unique: true
  end

  add_foreign_key "meetings", "users", column: "industrial_id"
  add_foreign_key "meetings", "users", column: "project_manager_id"
end
