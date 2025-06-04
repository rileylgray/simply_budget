# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_04_213552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "expense_category_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "time_frame", default: 0, null: false
    t.index ["expense_category_id"], name: "index_budgets_on_expense_category_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "expense_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "expense_id"
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_categories_on_expense_id"
    t.index ["user_id"], name: "index_expense_categories_on_user_id"
  end

  create_table "expense_categorizations", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "expense_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_category_id"], name: "index_expense_categorizations_on_expense_category_id"
    t.index ["expense_id"], name: "index_expense_categorizations_on_expense_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.date "spent_on", null: false
    t.string "notes"
    t.integer "frequency", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "end_date"
    t.string "chart_color", default: "#F44336"
    t.index ["end_date"], name: "index_expenses_on_end_date"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "income_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_income_categories_on_user_id"
  end

  create_table "income_categorizations", force: :cascade do |t|
    t.bigint "income_id", null: false
    t.bigint "income_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["income_category_id"], name: "index_income_categorizations_on_income_category_id"
    t.index ["income_id"], name: "index_income_categorizations_on_income_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "source"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.date "received_on"
    t.string "notes"
    t.integer "frequency", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "end_date"
    t.string "chart_color", default: "#4CAF50"
    t.index ["end_date"], name: "index_incomes_on_end_date"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email", null: false
    t.string "password_digest"
    t.string "role"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "budgets", "expense_categories"
  add_foreign_key "budgets", "users"
  add_foreign_key "expense_categories", "expenses"
  add_foreign_key "expense_categories", "users"
  add_foreign_key "expense_categorizations", "expense_categories"
  add_foreign_key "expense_categorizations", "expenses"
  add_foreign_key "expenses", "users"
  add_foreign_key "income_categories", "users"
  add_foreign_key "income_categorizations", "income_categories"
  add_foreign_key "income_categorizations", "incomes"
  add_foreign_key "incomes", "users"
end
