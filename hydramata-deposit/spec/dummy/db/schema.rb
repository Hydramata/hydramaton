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

ActiveRecord::Schema.define(version: 20140130173601) do

  create_table "hydramata_core_work_drafts", primary_key: "false", force: true do |t|
    t.string  "pid"
    t.string  "work_type",        limit: 64
    t.integer "owner"
    t.string  "owner_type",       limit: 64
    t.text    "attributes_store", limit: 2147483647
  end

  add_index "hydramata_core_work_drafts", ["owner", "owner_type"], name: "index_hydramata_core_work_drafts_on_owner_and_owner_type"

end
