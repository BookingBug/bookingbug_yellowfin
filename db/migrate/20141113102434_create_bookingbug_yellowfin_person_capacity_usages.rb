class CreateBookingbugYellowfinPersonCapacityUsages < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_person_capacity_usages do |t|
      t.integer :person_id
      t.string :date
      t.float :total_time
      t.float :percent_booked
      t.float :percent_blocked
    end
  end
end