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

ActiveRecord::Schema.define(:version => 20141110144754) do

  create_table "booking_details", :force => true do |t|
    t.integer  "booking_id"
    t.string   "occurance_id"
    t.string   "company"
    t.string   "created_at",             :null => false
    t.string   "member"
    t.string   "service"
    t.string   "resource"
    t.string   "person"
    t.string   "session"
    t.string   "date"
    t.string   "day_of_week"
    t.string   "month"
    t.string   "time"
    t.string   "duration"
    t.string   "price"
    t.string   "paid"
    t.string   "status"
    t.string   "coupon_code"
    t.string   "repeat_booking"
    t.string   "purchase_item"
    t.string   "cancellation_date_time"
    t.string   "late"
    t.datetime "updated_at",             :null => false
  end

end
