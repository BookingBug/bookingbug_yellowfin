module BookingbugYellowfin
  class TradingPeriod < ActiveRecord::Base
    # attr_accessible :title, :body
    def self.import_csv csv_filepath
      csv_text = File.read(csv_filepath)
      csv = CSV.parse(csv_text, :headers => false)
      csv.each do |row|
        BookingbugYellowfin::TradingPeriod.create!(date: ::Date.parse(row[0]), yf_date: BookingbugYellowfin::FormatHelpers.to_yf_format(::Date.parse(row[0])), year: row[1].to_i, month: row[2], period: row[3].to_i, week: row[4].to_i)
      end
    end
  end
end