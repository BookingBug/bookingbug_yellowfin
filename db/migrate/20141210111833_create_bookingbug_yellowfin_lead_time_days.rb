class CreateBookingbugYellowfinLeadTimeDays < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_lead_time_days do |t|
      t.date :date
      t.integer :service_id
      t.string :yf_format_date
      t.string :sunday_am
      t.string :sunday_pm
      t.string :sunday_ev
      t.string :monday_am
      t.string :monday_pm
      t.string :monday_ev
      t.string :tuesday_am
      t.string :tuesday_pm
      t.string :tuesday_ev
      t.string :wednesday_am
      t.string :wednesday_pm
      t.string :wednesday_ev
      t.string :thursday_am
      t.string :thursday_pm
      t.string :thursday_ev
      t.string :friday_am
      t.string :friday_pm
      t.string :friday_ev
      t.string :saturday_am
      t.string :saturday_pm
      t.string :saturday_ev
      t.timestamps
    end
  end
end
