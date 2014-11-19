class CreateBookingbugYellowfinBookingDetails < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_booking_details do |t|
      t.integer :booking_id
      t.integer :slot_id
      t.string :company_id
      t.string :booking_created_at
      t.string :yf_format_booking_created_at
      t.integer :member_id
      t.string :service
      t.string :resource
      t.string :person
      t.string :session
      t.string :just_date
      t.string :yf_format_just_date
      t.string :day_of_week
      t.string :month
      t.string :just_time
      t.string :duration
      t.string :price
      t.integer :paid
      t.string :s_status
      t.string :coupon_code
      t.integer :repeat_booking_id
      t.integer :purchase_item_id
      t.string :cancellation_date
      t.string :late_cancel
      t.string :attended
      t.string :name
      t.string :channel
      t.string :readable_current_multi_stat
      t.string :notes
      t.string :feedback
      t.string :pretty_print_multi_status
    end
  end
end