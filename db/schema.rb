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

ActiveRecord::Schema.define(version: 20140415231540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "inputs", force: true do |t|
    t.integer  "quantity"
    t.integer  "employee_id"
    t.integer  "warehouse_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inputs", ["employee_id"], name: "index_inputs_on_employee_id", using: :btree
  add_index "inputs", ["product_id"], name: "index_inputs_on_product_id", using: :btree
  add_index "inputs", ["warehouse_id"], name: "index_inputs_on_warehouse_id", using: :btree

  create_table "outputs", force: true do |t|
    t.integer  "quantity"
    t.integer  "employee_id"
    t.integer  "warehouse_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outputs", ["employee_id"], name: "index_outputs_on_employee_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["provider_id"], name: "index_products_on_provider_id", using: :btree

  create_table "providers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: true do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "warehouse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stocks", ["product_id"], name: "index_stocks_on_product_id", using: :btree
  add_index "stocks", ["warehouse_id"], name: "index_stocks_on_warehouse_id", using: :btree

  create_table "warehouses", force: true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "complement"
    t.string   "cep"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
