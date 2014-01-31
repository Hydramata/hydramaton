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

ActiveRecord::Schema.define(version: 20140131203748) do

  create_table "hydramata_core_attachments", id: false, force: true do |t|
    t.string   "pid",                   limit: 32, null: false
    t.string   "attached_to_pid",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attached_file_name"
    t.string   "attached_content_type"
    t.integer  "attached_file_size"
    t.datetime "attached_updated_at"
  end

  add_index "hydramata_core_attachments", ["attached_to_pid"], name: "index_hydramata_core_attachments_on_attached_to_pid"
  add_index "hydramata_core_attachments", ["pid"], name: "index_hydramata_core_attachments_on_pid"

  create_table "hydramata_core_relationships", force: true do |t|
    t.string   "subject_id",   limit: 32
    t.string   "subject_type", limit: 32
    t.string   "relationship", limit: 64
    t.string   "target_id",    limit: 32
    t.string   "target_type",  limit: 32
    t.integer  "creator_id"
    t.string   "creator_type", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydramata_core_relationships", ["creator_id", "creator_type"], name: "hc_rel_creator"
  add_index "hydramata_core_relationships", ["subject_id", "subject_type"], name: "hc_rel_subject"
  add_index "hydramata_core_relationships", ["target_id", "target_type"], name: "hc_rel_target"

  create_table "hydramata_core_work_drafts", id: false, force: true do |t|
    t.string   "pid",                                 null: false
    t.string   "work_type",        limit: 64,         null: false
    t.integer  "owner_id"
    t.string   "owner_type",       limit: 64
    t.text     "attributes_store", limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydramata_core_work_drafts", ["owner_id", "owner_type"], name: "index_hydramata_core_work_drafts_on_owner_id_and_owner_type"

end
