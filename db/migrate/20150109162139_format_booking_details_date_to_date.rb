class FormatBookingDetailsDateToDate < ActiveRecord::Migration
  def up
    change_column :bookingbug_yellowfin_booking_details, :booking_created_at,  :date
  end

  def down
    change_column :bookingbug_yellowfin_booking_details, :booking_created_at,  :string
  end
end
