module BookingbugYellowfin
  class Date < ActiveRecord::Base
    validates_uniqueness_of :date
    attr_accessible :date, :typed_date

    def self.populate_four_months_forward
      p 'populate date four months forward'
      $stdout.sync = true
      
      last_date = BookingbugYellowfin::Date.last || BookingbugYellowfin::Date.create(date: ::Date.today.strftime("%Y/%m/%d"), typed_date: ::Date.today.to_s)

      ::Date.parse(last_date.date).upto(::Date.today+4.months) do |d|
        print '.'
        BookingbugYellowfin::Date.create(date: d.strftime("%Y/%m/%d"), typed_date: d)
      end
    end
  end
end