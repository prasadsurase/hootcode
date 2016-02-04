# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160203122410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "submission_id", null: false
    t.text     "body"
    t.text     "html_body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["submission_id"], name: "index_comments_on_submission_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "lifecycle_events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lifecycle_events", ["user_id"], name: "index_lifecycle_events_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "submission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["submission_id"], name: "index_likes_on_submission_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "muted_submissions", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "submission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "muted_submissions", ["submission_id"], name: "index_muted_submissions_on_submission_id", using: :btree
  add_index "muted_submissions", ["user_id"], name: "index_muted_submissions_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "regarding"
    t.boolean  "read"
    t.integer  "count",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "submission_viewers", force: :cascade do |t|
    t.integer  "submission_id", null: false
    t.integer  "viewer_id",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "submission_viewers", ["submission_id"], name: "index_submission_viewers_on_submission_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "state"
    t.string   "language"
    t.string   "slug"
    t.text     "code"
    t.datetime "done_at"
    t.boolean  "is_liked"
    t.integer  "nit_count",        null: false
    t.integer  "version"
    t.integer  "user_exercise_id"
    t.string   "filename"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "team_managers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_managers", ["user_id"], name: "index_team_managers_on_user_id", using: :btree

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_memberships", ["team_id"], name: "index_team_memberships_on_team_id", using: :btree
  add_index "team_memberships", ["user_id"], name: "index_team_memberships_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "creator_id", null: false
    t.string   "slug",       null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_exercises", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_exercises", ["user_id"], name: "index_user_exercises_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "avatar_url"
    t.string   "key"
    t.text     "mastery"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "alerts", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "submissions"
  add_foreign_key "likes", "users"
  add_foreign_key "muted_submissions", "submissions"
  add_foreign_key "muted_submissions", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "submission_viewers", "submissions"
  add_foreign_key "submissions", "users"
  add_foreign_key "team_managers", "users"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "user_exercises", "users"
end
