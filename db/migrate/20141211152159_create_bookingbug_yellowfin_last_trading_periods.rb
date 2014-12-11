class CreateBookingbugYellowfinLastTradingPeriods < ActiveRecord::Migration
  def change
    create_table :bookingbug_yellowfin_last_trading_periods do |t|
      t.date :date
      t.string :yf_date
      t.integer :period
      t.integer :week
      t.timestamps
    end
  end
end
