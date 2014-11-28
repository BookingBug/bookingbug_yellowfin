module BookingbugYellowfin
  class PersonCapacityUsage < ActiveRecord::Base

    # Historical capacity usage

    attr_accessible :person_id, :date, :total_time_hrs, :time_booked_hrs, :time_blocked_hrs, :yf_format_date

# :total_time_hrs
#       t.float :time_booked_hrs
#       t.float :time_blocked_hrs

    def self.populate_all_capacity_usage
      failed_imports = []
      Company.find_each() do |company|
        (::Date.today - 4.weeks).to_date.upto(::Date.today) do |date|
          begin
            add_person_capacity_for_company company.id, date
          rescue
            failed_imports << [date, company.id]
          end
        end
      end
      p 'failed_imports **********'
      p failed_imports
      return true
    end

    def self.amend_yesterdays_capacity_usage
      Company.find_each() do |company|
        add_person_capacity_for_company company.id, 1.day.ago
      end
    end

# company 37212
# BookingbugYellowfin::PersonCapacityUsage.add_person_capacity_for_company 37212
    def self.add_person_capacity_for_company company_id, date = ::Date.yesterday
      for person in Person.where(company_id: company_id, deleted: false)
        booked_time = 0
        blocked_time = 0
        next if person.schedule.blank?
        total_time = person.schedule.total_time_available_for_date(date)/60.0 #Convert to hours
        booked_slots = Slot.where(person_id: person.id, date: date, status: Slot::BOOKING_BOOKED)
        for slot in booked_slots
          booked_time += slot.ilen*5
        end
        blocked_slots = Slot.where(person_id: person.id, date: date, status: Slot::BOOKING_BLOCKED)
        for slot in blocked_slots
          if slot.slot_type == Schedule::DAY && slot.ilen == 1
            blocked_time += (total_time * 60)
          else
            blocked_time += slot.ilen*5
          end
        end
        booked_time = booked_time/60.0
        blocked_time = (total_time*60) if (total_time*60) < blocked_time
        blocked_time = blocked_time/60.0
        capacity_record = self.where(person_id: person.id, date: date).first
        if capacity_record.present?
          capacity_record.update_attributes(person_id: person.id, date: date, yf_format_date: BookingbugYellowfin::FormatHelpers.to_yf_format(date), total_time_hrs: total_time, time_booked_hrs: booked_time, time_blocked_hrs: blocked_time)
        else
          self.create(person_id: person.id, date: date, yf_format_date: BookingbugYellowfin::FormatHelpers.to_yf_format(date), total_time_hrs: total_time, time_booked_hrs: booked_time, time_blocked_hrs: blocked_time)
        end
      end
    end
  end
end

# [Sat, 27 Sep 2013, 36997]
# BookingbugYellowfin::PersonCapacityUsage.populate_all_capacity_usage

# BookingbugYellowfin::PersonCapacityUsage.add_person_capacity_for_company company_id, date

# [Sat, 28 Sep 2013, 36997]

# SELECT table_schema "fco", sum( data_length + index_length ) / 1024 / 1024 "Data Base Size in MB" 
# FROM information_schema.TABLES GROUP BY table_schema ; 



