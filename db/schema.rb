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

ActiveRecord::Schema.define(version: 20180225004806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "components", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipe_id"
    t.text "description"
    t.index ["recipe_id"], name: "index_components_on_recipe_id"
  end

  create_table "ingredients", id: :serial, force: :cascade do |t|
    t.decimal "amount"
    t.string "unit"
    t.string "title"
    t.integer "component_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.index ["component_id"], name: "index_ingredients_on_component_id"
    t.index ["product_id"], name: "index_ingredients_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "liquid"
    t.integer "tsp"
    t.integer "tbsp"
    t.decimal "energy"
    t.decimal "protein"
    t.decimal "fat_total"
    t.decimal "fat_saturated"
    t.decimal "carbohydrate"
    t.decimal "sugar"
    t.decimal "magnesium"
    t.decimal "calcium"
    t.decimal "potassium"
    t.decimal "iron"
    t.decimal "zinc"
    t.decimal "iodine"
    t.decimal "omega3"
    t.decimal "selenium"
    t.decimal "fiber"
    t.decimal "natrium"
    t.decimal "folic"
    t.decimal "b1"
    t.decimal "b2"
    t.decimal "b3"
    t.decimal "b5"
    t.decimal "b6"
    t.decimal "b12"
    t.decimal "c"
    t.decimal "d2"
    t.decimal "e"
    t.decimal "h"
    t.decimal "k"
    t.decimal "a"
    t.decimal "b9"
    t.string "manufacturer"
    t.string "shop"
    t.string "code"
  end

  create_table "recipes", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.date "last"
    t.binary "picture"
    t.integer "serves"
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_sources_on_recipe_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_taggings_on_recipe_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nick"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "sources", "recipes"
  add_foreign_key "taggings", "recipes"
  add_foreign_key "taggings", "tags"
end
