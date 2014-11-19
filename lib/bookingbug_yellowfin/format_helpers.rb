module BookingbugYellowfin
  class FormatHelpers
    def self.to_yf_format date
      if date.respond_to? :strftime
        date.strftime('%Y/%m/%d')
      else # date.class = String
        date[0..9].gsub('-', '/')
      end
    end
  end
end