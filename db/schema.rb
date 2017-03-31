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

ActiveRecord::Schema.define(version: 20170331053123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.datetime "startdate"
    t.datetime "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "amount"
    t.string   "aasm_state"
  end

  create_table "portfolio_tickers", force: :cascade do |t|
    t.integer  "portfolio_id"
    t.integer  "ticker_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["portfolio_id"], name: "index_portfolio_tickers_on_portfolio_id", using: :btree
    t.index ["ticker_id"], name: "index_portfolio_tickers_on_ticker_id", using: :btree
  end

  create_table "portfolios", force: :cascade do |t|
    t.float    "startvalue"
    t.float    "currentvalue"
    t.date     "startdate"
    t.datetime "enddate"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "bet_id"
    t.string   "aasm_state"
    t.index ["bet_id"], name: "index_portfolios_on_bet_id", using: :btree
    t.index ["user_id"], name: "index_portfolios_on_user_id", using: :btree
  end

  create_table "tickers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ticker"
  end

  create_table "user_portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_portfolios_on_user_id", using: :btree
  end

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "timezone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "portfolio_tickers", "portfolios"
  add_foreign_key "portfolio_tickers", "tickers"
  add_foreign_key "portfolios", "bets"
  add_foreign_key "portfolios", "users"
  add_foreign_key "user_portfolios", "users"
end
