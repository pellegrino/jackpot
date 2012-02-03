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

ActiveRecord::Schema.define(:version => 20120130192147) do

  create_table "jackpot_customers", :force => true do |t|
    t.string   "email"
    t.text     "description"
    t.integer  "subscription_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "credit_card_number"
    t.integer  "credit_card_expiry_month"
    t.integer  "credit_card_expiry_year"
    t.string   "credit_card_token"
  end

  create_table "jackpot_payments", :force => true do |t|
    t.string   "token"
    t.integer  "amount"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "customer_name"
  end

  create_table "jackpot_subscriptions", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
