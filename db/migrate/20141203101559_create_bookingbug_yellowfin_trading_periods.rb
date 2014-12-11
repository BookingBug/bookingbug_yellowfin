class CreateBookingbugYellowfinTradingPeriods < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_trading_periods do |t|
      t.date :date
      t.string :yf_date
      t.integer :year
      t.string :month
      t.integer :period
      t.integer :week
      t.timestamps
    end
  end
end