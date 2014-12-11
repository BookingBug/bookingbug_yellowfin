module BookingbugYellowfin
  class LastTradingPeriod < ActiveRecord::Base
    def self.populate_all
      ::BookingbugYellowfin::TradingPeriod.find_each do |tp|
        tlp = self.find_or_initialize_by_date(tp.date)
        tlp.update_attributes yf_date: tp.yf_date, period: (tp.period-1), week: (tp.week-1)
      end
    end
  end
end