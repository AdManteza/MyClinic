# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_19_011859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.bigint "site_id"
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.string "password_digest"
    t.boolean "super", default: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_admin_users_on_site_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.bigint "patient_session_id"
    t.index ["patient_session_id"], name: "index_appointments_on_patient_session_id"
    t.index ["site_id"], name: "index_appointments_on_site_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "patient_sessions", force: :cascade do |t|
    t.bigint "site_id"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.index ["site_id"], name: "index_patient_sessions_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "homepage", default: "homepage"
    t.string "time_zone", default: "UTC"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.bigint "site_id"
    t.string "contact_number"
    t.string "email_address"
    t.index ["site_id"], name: "index_users_on_site_id"
  end

  add_foreign_key "appointments", "patient_sessions"
  add_foreign_key "appointments", "sites"
  add_foreign_key "users", "sites"
end
