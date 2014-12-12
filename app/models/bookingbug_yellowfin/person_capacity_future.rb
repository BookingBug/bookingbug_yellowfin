module BookingbugYellowfin
  class PersonCapacityFuture < ActiveRecord::Base
    # attr_accessible :title, :body
    # BookingbugYellowfin::PersonCapacityFuture.populate_all_capacity_usage
    def self.populate_all_capacity_usage
      p 'populate future capacity usage'
      $stdout.sync = true
      failed_imports = []
      for company in Company.where("cancelled != ? and template is null or template = ?", true, false)
          print '.'
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

    # BookingbugYellowfin::PersonCapacityFuture.add_person_capacity_for_company(37036, Date.parse('Wed, 03 Dec 2014'))
    def self.add_person_capacity_for_company company_id, date = ::Date.today
      for person in Person.where(company_id: company_id, deleted: false, disabled: false)
        capacity_record = self.where(person_id: person.id, date: date).first
        capacity_record = self.create(person_id: person.id, date: date, yf_format_date: FormatHelpers.to_yf_format(date)) if capacity_record.blank?
        FormatHelpers.to_yf_format(date)
        date.upto(date+20.days) do |cdate|
          booked_time = 0
          blocked_time = 0
          next if person.schedule.blank?
          total_time = person.schedule.total_time_available_for_date(cdate)/60.0 #Convert to hours
          booked_slots = Slot.where(person_id: person.id, date: cdate, status: Slot::BOOKING_BOOKED)
          for slot in booked_slots
            booked_time += slot.ilen*5
          end
          blocked_slots = Slot.where(person_id: person.id, date: cdate, status: Slot::BOOKING_BLOCKED)
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
          booked_time ||= 0.0
          blocked_time ||= 0.0
          capacity_record.update_attributes(build_attr_value_hash(cdate, total_time, booked_time, blocked_time))
        end
      end
    end

    def self.build_attr_value_hash date, total, booked, blocked
      if ::Date.today == date
        {date_total_time_hrs: total, date_time_booked_hrs: booked, date_time_blocked_hrs: blocked}
      else
        date_column = (date - ::Date.today)
        {"date_plus_#{date_column.humanize}_total_time_hrs" => total, "date_plus_#{date_column.humanize}_time_booked_hrs" => booked, "date_plus_#{date_column.humanize}_time_blocked_hrs" => blocked}
      end
    end
  end
end