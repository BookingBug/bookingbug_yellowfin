class AddYfDateChangeNotesFormat < ActiveRecord::Migration
  def up
    change_column :bookingbug_yellowfin_booking_details, :notes,  :text
    if !(BookingbugYellowfin::LeadTimes.column_names.include? "yf_format_date")
      add_column :bookingbug_yellowfin_lead_times, :yf_format_date,  :string
    end
  end

  def down
  end
end
