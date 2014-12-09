class IndexTables < ActiveRecord::Migration
  def up
    add_index :companies, :id
    add_index :companies, :name
    add_index :services, :company_id
    add_index :companies, :parent_id
    add_index :slots, :service_id
    add_index :services, :id
    add_index :slots, :id
    add_index :slots, :created_at
    add_index :bookingbug_yellowfin_booking_details, :slot_id
    add_index :bookingbug_yellowfin_dates, :date
    add_index :bookingbug_yellowfin_dates, :typed_date
    add_index :bookingbug_yellowfin_booking_details, :s_status
    add_index :bookingbug_yellowfin_trading_periods, :week
    add_index :bookingbug_yellowfin_trading_periods, :yf_date
    add_index :bookingbug_yellowfin_booking_details, :channel
    add_index :conf_extra_answers, :foreign_id
    add_index :conf_extra_questions, :id
    add_index :conf_extra_questions, :name
    add_index :conf_extra_answers, :extra_question_id
    add_index :conf_extra_answers, :answer
    add_index :bookingbug_yellowfin_lead_times, :service_id
    add_index :groups, :id
    add_index :people, :group_id
    add_index :people, :id
    add_index :bookingbug_yellowfin_person_capacity_usages, :id
  end

  def down
  end
end
