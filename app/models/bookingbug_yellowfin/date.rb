module BookingbugYellowfin
  class Date < ActiveRecord::Base
    validates_uniqueness_of :date
    attr_accessible :date

    def self.populate_six_months_forward
      p 'populate date six months forward'
      $stdout.sync = true
      last_date = BookingbugYellowfin::Date.last
      ::Date.parse(last_date.date).upto(::Date.today+4.months) do |d|
        print '.'
        BookingbugYellowfin::Date.create(date: d.strftime("%Y/%m/%d"))
      end
    end
  end
end