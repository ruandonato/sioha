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

ActiveRecord::Schema.define(version: 20151129103107) do

  create_table "invites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.boolean "pending",  default: true
    t.boolean "accepted"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "team_id"
    t.string   "type"
    t.string   "priority"
    t.string   "description"
    t.string   "code"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",      default: "to-do"
  end

  create_table "team_members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.string  "description"
    t.string  "email"
    t.string  "picture"
    t.boolean "public_to_members", default: false
    t.string  "methodology"
    t.string  "wiki",              default: "*Hello! My wiki is empty. :(*"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.string  "login"
    t.string  "description"
    t.string  "about"
    t.string  "remember_token"
    t.string  "password_digest"
    t.string  "picture"
    t.boolean "public_email",    default: false
    t.float   "latitude"
    t.float   "longitude"
  end

end
