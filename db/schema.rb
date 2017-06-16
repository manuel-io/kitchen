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

ActiveRecord::Schema.define(version: 20170616151804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "components", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "recipe_id"
    t.text     "description"
    t.index ["recipe_id"], name: "index_components_on_recipe_id", using: :btree
  end

  create_table "ingredients", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "unit"
    t.string   "name"
    t.integer  "component_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["component_id"], name: "index_ingredients_on_component_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.date     "last"
    t.binary   "picture"
    t.integer  "portion"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_sources_on_recipe_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "sources", "recipes"
end
