class CreateBookingbugYellowfinPersonCapacityUsages < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_person_capacity_usages do |t|
      t.integer :person_id
      t.string :date
      t.float :total_time_hrs
      t.float :time_booked_hrs
      t.float :time_blocked_hrs
    end
  end
end