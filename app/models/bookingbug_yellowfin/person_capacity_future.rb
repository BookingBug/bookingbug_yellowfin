module BookingbugYellowfin
  class PersonCapacityFuture < ActiveRecord::Base
    # attr_accessible :title, :body

    def self.populate_all_capacity_usage
      failed_imports = []
      Company.find_each() do |company|
          date = ::Date.today
          begin
            add_person_capacity_for_company company.id, date
          rescue
            failed_imports << [date, company.id]
          end
      end
      p 'failed_imports **********'
      p failed_imports
      return true
    end

    def self.add_person_capacity_for_company company_id, date = ::Date.today
      for person in Person.where(company_id: company_id, deleted: false)
        capacity_record = self.where(person_id: person.id, date: date).first
        capacity_record = self.create(person_id: person.id, date: date, yf_format_date: FormatHelpers.to_yf_format(date)) if capacity_record.blank?
        FormatHelpers.to_yf_format(date)
        date.upto(date+3.weeks) do |cdate|
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
          booked_time||= 0.0
          blocked_time||= 0.0
          capacity_record.update_attributes(build_attr_value_hash(date, cdate, total_time, booked_time, blocked_time))
        end
      end
    end

    def self.build_attr_value_hash start_date, date, total, booked, blocked
      if date == ::Date.today
        {date_total_time_hrs: total, date_time_booked_hrs: booked, date_time_blocked_hrs: blocked}
      else
        diff = (date - ::Date.today).to_i
        {"date_plus_#{diff.humanize}_total_time_hrs" => total, "date_plus_#{diff.humanize}_time_booked_hrs" => booked, "date_plus_#{diff.humanize}_time_blocked_hrs" => blocked}
      end
    end

  end
end