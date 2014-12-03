class AddNonStringDateToDate < ActiveRecord::Migration
  def change
    # add_column :bookingbug_yellowfin_dates, :typed_date, :date

    BookingbugYellowfin::Date.find_each() do |date|
      date.typed_date = Date.parse(date.date)
      date.save
    end
  end
end
