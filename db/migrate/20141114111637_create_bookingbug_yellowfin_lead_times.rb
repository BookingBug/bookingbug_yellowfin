class CreateBookingbugYellowfinLeadTimes < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_lead_times do |t|
      t.date :date
      t.integer :service_id
      t.string :yf_format_date
      t.string :next_am
      t.string :next_pm
      t.string :next_ev
      t.string :date_plus_one_next_am
      t.string :date_plus_one_next_pm
      t.string :date_plus_one_next_ev
      t.string :date_plus_two_next_am
      t.string :date_plus_two_next_pm
      t.string :date_plus_two_next_ev
      t.string :date_plus_three_next_am
      t.string :date_plus_three_next_pm
      t.string :date_plus_three_next_ev
      t.string :date_plus_four_next_am
      t.string :date_plus_four_next_pm
      t.string :date_plus_four_next_ev
      t.string :date_plus_five_next_am
      t.string :date_plus_five_next_pm
      t.string :date_plus_five_next_ev
      t.string :date_plus_six_next_am
      t.string :date_plus_six_next_pm
      t.string :date_plus_six_next_ev
      t.timestamps
    end
  end

  
end
