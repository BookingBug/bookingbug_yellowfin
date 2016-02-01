class AdditionalColumnsForReportingTradingPeriods < ActiveRecord::Migration
  def change
    add_column :bookingbug_yellowfin_trading_periods, :period_string, :string
    add_column :bookingbug_yellowfin_trading_periods, :week_string, :string
    add_column :bookingbug_yellowfin_trading_periods, :day_string, :string
  end
end
