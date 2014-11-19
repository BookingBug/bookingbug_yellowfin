class CreateBookingbugYellowfinDates < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_dates do |t|
      t.string :date
    end
    Date.today.beginning_of_year.upto(Date.today.end_of_year) do |date|
      self.create(date: BookingbugYellowfin::FormatHelpers.to_yf_format(date))
    end
  end
end