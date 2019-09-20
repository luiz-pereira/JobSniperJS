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

ActiveRecord::Schema.define(version: 2019_08_30_223336) do

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

  create_table "job_titles_selections", force: :cascade do |t|
    t.string "title_select"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "date_updated"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_title"
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
