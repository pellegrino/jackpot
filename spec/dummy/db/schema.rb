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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120214020231) do

  create_table "jackpot_customers", :force => true do |t|
    t.string   "email"
    t.text     "description"
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "credit_card_number"
    t.integer  "credit_card_expiry_month"
    t.integer  "credit_card_expiry_year"
    t.string   "credit_card_token"
    t.date     "good_until"
  end

  create_table "jackpot_payments", :force => true do |t|
    t.string   "payment_transaction_token"
    t.integer  "amount"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_name"
    t.integer  "subscription_id"
    t.integer  "customer_id"
  end

  create_table "jackpot_subscriptions", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "billing_period"
  end

  create_table "jackpot_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jackpot_users", ["authentication_token"], :name => "index_jackpot_users_on_authentication_token", :unique => true
  add_index "jackpot_users", ["email"], :name => "index_jackpot_users_on_email", :unique => true
  add_index "jackpot_users", ["reset_password_token"], :name => "index_jackpot_users_on_reset_password_token", :unique => true

end
