module BookingbugYellowfin
  class PersonCapacityUsage < ActiveRecord::Base
    # attr_accessible :title, :body
      # t.integer :person_id
      # t.string :date
      # t.string :total_time
      # t.string :percent_booked
      # t.string :percent_blocked
    def self.populate_all_capacity_usage
      Company.find_each() do |company|
        # TODO loop through list of all dates from company.created_at.to_date to Date.today
          add_person_capacity_for_company company.id, company.created_at.to_date
      end
    end

    def self.amend_yesterdays_capacity_usage
      Company.find_each() do |company|
        add_person_capacity_for_company company.id, 1.day.ago
      end
    end

    def self.add_person_capacity_for_company company_id, date = Date.yesterday
      for person in Person.where(company_id: company_id, deleted: false)
        booked_time = 0
        blocked_time = 0
        total_time = person.schedule.total_time_available_for_date(date)/60.0 #Convert to hours
        booked_slots = Slot.where(person_id: person.id, date: date, status: Slot::BOOKING_BOOKED)
        for slot in booked_slots
          booked_time += slot.ilen*5
        end
        blocked_slots = Slot.where(person_id: person.id, date: date, status: Slot::BOOKING_BLOCKED)
        for slot in blocked_slots
          blocked_time += slot.ilen*5
        end
        booked_time = booked_time/60.0
        blocked_time = blocked_time/60.0
        if p.present?
          p.first.update_attributes(person_id: person.id, date: date, total_time: total_time, percent_booked: (booked_time.to_f/total_time)*100, percent_blocked: (blocked_time.to_f/total_time)*100)
        else
          self.create(person_id: person.id, date: date, total_time: total_time, percent_booked: (booked_time.to_f/total_time)*100, percent_blocked: (blocked_time.to_f/total_time)*100)
        end
      end
    end
  end
end


# BookingbugYellowfin::PersonCapacityUsage.add_person_capacity_for_company 37024