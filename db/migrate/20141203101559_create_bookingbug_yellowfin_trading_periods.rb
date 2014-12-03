class CreateBookingbugYellowfinTradingPeriods < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_trading_periods do |t|
      t.date :date
      t.string :yf_date
      t.int :year
      t.string :month
      t.int :period
      t.int :week
      t.timestamps
    end
  end
end