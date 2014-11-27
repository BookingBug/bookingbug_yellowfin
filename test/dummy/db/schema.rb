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

ActiveRecord::Schema.define(:version => 20141125170252) do

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

  create_table "bookingbug_yellowfin_dates", :force => true do |t|
    t.string "date"
  end

  create_table "bookingbug_yellowfin_lead_times", :force => true do |t|
    t.date     "date"
    t.integer  "service_id"
    t.string   "next_am"
    t.string   "next_pm"
    t.string   "next_ev"
    t.string   "date_plus_one_next_am"
    t.string   "date_plus_one_next_pm"
    t.string   "date_plus_one_next_ev"
    t.string   "date_plus_two_next_am"
    t.string   "date_plus_two_next_pm"
    t.string   "date_plus_two_next_ev"
    t.string   "date_plus_three_next_am"
    t.string   "date_plus_three_next_pm"
    t.string   "date_plus_three_next_ev"
    t.string   "date_plus_four_next_am"
    t.string   "date_plus_four_next_pm"
    t.string   "date_plus_four_next_ev"
    t.string   "date_plus_five_next_am"
    t.string   "date_plus_five_next_pm"
    t.string   "date_plus_five_next_ev"
    t.string   "date_plus_six_next_am"
    t.string   "date_plus_six_next_pm"
    t.string   "date_plus_six_next_ev"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "bookingbug_yellowfin_person_capacity_futures", :force => true do |t|
    t.integer  "person_id"
    t.string   "date"
    t.string   "yf_format_date"
    t.float    "date_total_time_hrs"
    t.float    "date_time_booked_hrs"
    t.float    "date_time_blocked_hrs"
    t.float    "date_plus_one_total_time_hrs"
    t.float    "date_plus_one_time_booked_hrs"
    t.float    "date_plus_one_time_blocked_hrs"
    t.float    "date_plus_two_total_time_hrs"
    t.float    "date_plus_two_time_booked_hrs"
    t.float    "date_plus_two_time_blocked_hrs"
    t.float    "date_plus_three_total_time_hrs"
    t.float    "date_plus_three_time_booked_hrs"
    t.float    "date_plus_three_time_blocked_hrs"
    t.float    "date_plus_four_total_time_hrs"
    t.float    "date_plus_four_time_booked_hrs"
    t.float    "date_plus_four_time_blocked_hrs"
    t.float    "date_plus_five_total_time_hrs"
    t.float    "date_plus_five_time_booked_hrs"
    t.float    "date_plus_five_time_blocked_hrs"
    t.float    "date_plus_six_total_time_hrs"
    t.float    "date_plus_six_time_booked_hrs"
    t.float    "date_plus_six_time_blocked_hrs"
    t.float    "date_plus_seven_total_time_hrs"
    t.float    "date_plus_seven_time_booked_hrs"
    t.float    "date_plus_seven_time_blocked_hrs"
    t.float    "date_plus_eight_total_time_hrs"
    t.float    "date_plus_eight_time_booked_hrs"
    t.float    "date_plus_eight_time_blocked_hrs"
    t.float    "date_plus_nine_total_time_hrs"
    t.float    "date_plus_nine_time_booked_hrs"
    t.float    "date_plus_nine_time_blocked_hrs"
    t.float    "date_plus_ten_total_time_hrs"
    t.float    "date_plus_ten_time_booked_hrs"
    t.float    "date_plus_ten_time_blocked_hrs"
    t.float    "date_plus_eleven_total_time_hrs"
    t.float    "date_plus_eleven_time_booked_hrs"
    t.float    "date_plus_eleven_time_blocked_hrs"
    t.float    "date_plus_twelve_total_time_hrs"
    t.float    "date_plus_twelve_time_booked_hrs"
    t.float    "date_plus_twelve_time_blocked_hrs"
    t.float    "date_plus_thirteen_total_time_hrs"
    t.float    "date_plus_thirteen_time_booked_hrs"
    t.float    "date_plus_thirteen_time_blocked_hrs"
    t.float    "date_plus_fourteen_total_time_hrs"
    t.float    "date_plus_fourteen_time_booked_hrs"
    t.float    "date_plus_fourteen_time_blocked_hrs"
    t.float    "date_plus_fifteen_total_time_hrs"
    t.float    "date_plus_fifteen_time_booked_hrs"
    t.float    "date_plus_fifteen_time_blocked_hrs"
    t.float    "date_plus_sixteen_total_time_hrs"
    t.float    "date_plus_sixteen_time_booked_hrs"
    t.float    "date_plus_sixteen_time_blocked_hrs"
    t.float    "date_plus_seventeen_total_time_hrs"
    t.float    "date_plus_seventeen_time_booked_hrs"
    t.float    "date_plus_seventeen_time_blocked_hrs"
    t.float    "date_plus_eighteen_total_time_hrs"
    t.float    "date_plus_eighteen_time_booked_hrs"
    t.float    "date_plus_eighteen_time_blocked_hrs"
    t.float    "date_plus_nineteen_total_time_hrs"
    t.float    "date_plus_nineteen_time_booked_hrs"
    t.float    "date_plus_nineteen_time_blocked_hrs"
    t.float    "date_plus_twenty_total_time_hrs"
    t.float    "date_plus_twenty_time_booked_hrs"
    t.float    "date_plus_twenty_time_blocked_hrs"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "bookingbug_yellowfin_person_capacity_usages", :force => true do |t|
    t.integer "person_id"
    t.string  "date"
    t.string  "yf_format_date"
    t.float   "total_time_hrs"
    t.float   "time_booked_hrs"
    t.float   "time_blocked_hrs"
  end

end
