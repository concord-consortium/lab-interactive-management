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

ActiveRecord::Schema.define(version: 20130522184940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: true do |t|
    t.text     "json_rep"
    t.text     "revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactive_models", force: true do |t|
    t.integer  "interactive_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interactive_models", ["interactive_id"], name: "index_interactive_models_on_interactive_id", using: :btree
  add_index "interactive_models", ["model_id", "model_type"], name: "index_interactive_models_on_model_id_and_model_type", using: :btree

  create_table "interactives", force: true do |t|
    t.text     "json_rep"
    t.string   "revision"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "from_import", default: false
  end

  add_index "interactives", ["group_id"], name: "index_interactives_on_group_id", using: :btree

  create_table "md2ds", force: true do |t|
    t.text     "json_rep"
    t.string   "revision"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "from_import", default: false
  end

end
