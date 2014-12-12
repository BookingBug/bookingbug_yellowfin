module BookingbugYellowfin
  class LeadTimeDays < ActiveRecord::Base
    # attr_accessible :title, :body

    # This is the same as the lead times table uses day names instead of day+1 etc
    def self.populate_lead_time_days
      date = ::Date.today
      ::BookingbugYellowfin::LeadTimes.where(date: Date.today).find_each do |lead_time|
        lead_time_day = self.where(date: lead_time.date, service_id: lead_time.service_id).first
        lead_time_day ||= self.new(date: lead_time.date, service_id: lead_time.service_id, yf_format_date: FormatHelpers.to_yf_format(date))
        # very sloppy and not very readable but took 2 mins to do
        # TODO write nicer
        lead_time_day.update_attributes(
          (Date::DAYNAMES[date.wday].downcase+'_am') => lead_time.next_am,
          (Date::DAYNAMES[date.wday].downcase+'_pm') => lead_time.next_pm,
          (Date::DAYNAMES[date.wday].downcase+'_ev') => lead_time.next_ev,
          (Date::DAYNAMES[(date.wday+1)%7].downcase+'_am') => lead_time.date_plus_one_next_am,
          (Date::DAYNAMES[(date.wday+1)%7].downcase+'_pm') => lead_time.date_plus_one_next_pm,
          (Date::DAYNAMES[(date.wday+1)%7].downcase+'_ev') => lead_time.date_plus_one_next_ev,
          (Date::DAYNAMES[(date.wday+2)%7].downcase+'_am') => lead_time.date_plus_two_next_am,
          (Date::DAYNAMES[(date.wday+2)%7].downcase+'_pm') => lead_time.date_plus_two_next_pm,
          (Date::DAYNAMES[(date.wday+2)%7].downcase+'_ev') => lead_time.date_plus_two_next_ev,
          (Date::DAYNAMES[(date.wday+3)%7].downcase+'_am') => lead_time.date_plus_three_next_am,
          (Date::DAYNAMES[(date.wday+3)%7].downcase+'_pm') => lead_time.date_plus_three_next_pm,
          (Date::DAYNAMES[(date.wday+3)%7].downcase+'_ev') => lead_time.date_plus_three_next_ev,
          (Date::DAYNAMES[(date.wday+4)%7].downcase+'_am') => lead_time.date_plus_four_next_am,
          (Date::DAYNAMES[(date.wday+4)%7].downcase+'_pm') => lead_time.date_plus_four_next_pm,
          (Date::DAYNAMES[(date.wday+4)%7].downcase+'_ev') => lead_time.date_plus_four_next_ev,
          (Date::DAYNAMES[(date.wday+5)%7].downcase+'_am') => lead_time.date_plus_five_next_am,
          (Date::DAYNAMES[(date.wday+5)%7].downcase+'_pm') => lead_time.date_plus_five_next_pm,
          (Date::DAYNAMES[(date.wday+5)%7].downcase+'_ev') => lead_time.date_plus_five_next_ev,
          (Date::DAYNAMES[(date.wday+6)%7].downcase+'_am') => lead_time.date_plus_six_next_am,
          (Date::DAYNAMES[(date.wday+6)%7].downcase+'_pm') => lead_time.date_plus_six_next_pm,
          (Date::DAYNAMES[(date.wday+6)%7].downcase+'_ev') => lead_time.date_plus_six_next_ev,
          )
      end
    end
  end
end
