module BookingbugYellowfin
  class FormatHelpers
    def self.to_yf_format date
      if [ DateTime, ActiveSupport::TimeWithZone, Date].include? date.class
        date.strftime('%Y/%m/%d')
      else # date.class = String
        date_string[0..9].gsub('-', '/')
      end
    end
  end
end