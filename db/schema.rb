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

ActiveRecord::Schema.define(version: 2020_03_19_004653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "excludes", force: :cascade do |t|
    t.integer "request_id"
    t.string "criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "includes", force: :cascade do |t|
    t.integer "request_id"
    t.string "criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_titles", force: :cascade do |t|
    t.string "job_title"
    t.integer "request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_titles_selections", force: :cascade do |t|
    t.string "title_select"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "request_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "request_id"
    t.datetime "date_posted"
    t.string "source"
    t.string "title"
    t.string "company"
    t.text "description"
    t.string "tipe"
    t.string "seniority"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "link"
    t.string "summary"
    t.string "criteria"
    t.boolean "relevant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "province"
    t.string "country"
    t.integer "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pmi_emails", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "position"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "credentials"
    t.string "phone"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "date_updated"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "temporary"
  end

  create_table "standard_job_titles", force: :cascade do |t|
    t.string "job_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "linkedin"
  end

end
