class CreateBookingbugYellowfinPersonCapacityFutures < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_person_capacity_futures do |t|
      t.integer :person_id
      t.string :date
      t.string :yf_format_date
      t.float :date_total_time_hrs
      t.float :date_time_booked_hrs
      t.float :date_time_blocked_hrs
      t.float :date_plus_one_total_time_hrs
      t.float :date_plus_one_time_booked_hrs
      t.float :date_plus_one_time_blocked_hrs
      t.float :date_plus_two_total_time_hrs
      t.float :date_plus_two_time_booked_hrs
      t.float :date_plus_two_time_blocked_hrs
      t.float :date_plus_three_total_time_hrs
      t.float :date_plus_three_time_booked_hrs
      t.float :date_plus_three_time_blocked_hrs
      t.float :date_plus_four_total_time_hrs
      t.float :date_plus_four_time_booked_hrs
      t.float :date_plus_four_time_blocked_hrs
      t.float :date_plus_five_total_time_hrs
      t.float :date_plus_five_time_booked_hrs
      t.float :date_plus_five_time_blocked_hrs
      t.float :date_plus_six_total_time_hrs
      t.float :date_plus_six_time_booked_hrs
      t.float :date_plus_six_time_blocked_hrs
      t.float :date_plus_seven_total_time_hrs
      t.float :date_plus_seven_time_booked_hrs
      t.float :date_plus_seven_time_blocked_hrs
      t.float :date_plus_eight_total_time_hrs
      t.float :date_plus_eight_time_booked_hrs
      t.float :date_plus_eight_time_blocked_hrs
      t.float :date_plus_nine_total_time_hrs
      t.float :date_plus_nine_time_booked_hrs
      t.float :date_plus_nine_time_blocked_hrs
      t.float :date_plus_ten_total_time_hrs
      t.float :date_plus_ten_time_booked_hrs
      t.float :date_plus_ten_time_blocked_hrs
      t.float :date_plus_eleven_total_time_hrs
      t.float :date_plus_eleven_time_booked_hrs
      t.float :date_plus_eleven_time_blocked_hrs
      t.float :date_plus_twelve_total_time_hrs
      t.float :date_plus_twelve_time_booked_hrs
      t.float :date_plus_twelve_time_blocked_hrs
      t.float :date_plus_thirteen_total_time_hrs
      t.float :date_plus_thirteen_time_booked_hrs
      t.float :date_plus_thirteen_time_blocked_hrs
      t.float :date_plus_fourteen_total_time_hrs
      t.float :date_plus_fourteen_time_booked_hrs
      t.float :date_plus_fourteen_time_blocked_hrs
      t.float :date_plus_fifteen_total_time_hrs
      t.float :date_plus_fifteen_time_booked_hrs
      t.float :date_plus_fifteen_time_blocked_hrs
      t.float :date_plus_sixteen_total_time_hrs
      t.float :date_plus_sixteen_time_booked_hrs
      t.float :date_plus_sixteen_time_blocked_hrs
      t.float :date_plus_seventeen_total_time_hrs
      t.float :date_plus_seventeen_time_booked_hrs
      t.float :date_plus_seventeen_time_blocked_hrs
      t.float :date_plus_eighteen_total_time_hrs
      t.float :date_plus_eighteen_time_booked_hrs
      t.float :date_plus_eighteen_time_blocked_hrs
      t.float :date_plus_nineteen_total_time_hrs
      t.float :date_plus_nineteen_time_booked_hrs
      t.float :date_plus_nineteen_time_blocked_hrs
      t.float :date_plus_twenty_total_time_hrs
      t.float :date_plus_twenty_time_booked_hrs
      t.float :date_plus_twenty_time_blocked_hrs
      t.timestamps
    end
  end
end