module BookingbugYellowfin
  class LeadTimes < ActiveRecord::Base
    attr_accessible :date, :next_am, :next_pm, :next_ev, :date_plus_one_next_am, :date_plus_one_next_pm, :date_plus_one_next_ev, :date_plus_two_next_am, :date_plus_two_next_pm, :date_plus_two_next_ev, :date_plus_three_next_am, :date_plus_three_next_pm, :date_plus_three_next_ev, :date_plus_four_next_am, :date_plus_four_next_pm, :date_plus_four_next_ev, :date_plus_five_next_am, :date_plus_five_next_pm, :date_plus_five_next_ev, :date_plus_six_next_am, :date_plus_six_next_pm, :date_plus_six_next_ev

    def self.populate_lead_times
      Company.find_each() do |company|
        self.add_lead_times_for_company company_id
      end
    end

    def self.add_lead_times_for_company company_id
      for service in Service.where(company_id: company_id, deleted: false)
        # TODO
        # a) Refactor time data api into a class and use the class
        # b) Use a gem for the API

        lead_times = self.where(date: Date.today, service_id: service.id)
        lead_times = self.create(date: Date.today, service_id: service.id) if lead_times.blank?

        date = Date.today
        edate = date + 7.days
        uri = URI.parse("http://localhost:3000/api/v1/37024/time_data?date=#{date.iso8601}&num_resources=1&edate=#{edate.iso8601}")
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        request.add_field 'App-Id', '08f4a5e6'
        request.add_field 'App-Key', '6d6f6a0d11ccfe652b5ea94b5ad7deb6'
        response = http.request(request)
        data = JSON.parse(response.body)
        events = data['_embedded']['events']

        for event in events
          next if lead_times_found? lead_times, Date.parse(event["date"])
          event_date = Date.parse(event["date"])
          days_diff = (event_date - Date.today).to_i
          times = event["times"]
          if times.present?
            for time in times
              t = time["time"].to_i
              if t < 720 && time["avail"] == 1
                time_found lead_times, date, :am
              elsif t >= 720 && t < 1020 && time["avail"] == 1
                time_found lead_times, date, :am
              elsif t < 720 && time["avail"] == 1
                time_found lead_times, date, :am
              end
              break if lead_times_found? lead_times, Date.parse(event["date"])
            end
          end
        end
        lead_times.save!
      end
    end

    def self.lead_times_found? lead_times, date
      self.read_attribute(build_attr_name(date, :am)).present? &&
      self.read_attribute(build_attr_name(date, :pm)).present? &&
      self.read_attribute(build_attr_name(date, :ev)).present?
    end

    def self.time_found lead_times, date, time_period, service
      date.downto(Date.today) do |loop_date|
        # look at min cancellation date
        days_diff = (date-loop_date).to_i
        if lead_times.read_attribute(build_attr_name(date ,time_period)).nil? &&
          service.min_book_days < days_diff
          lead_times.write_attribute(build_attr_name(date ,time_period), days_diff)
        end
      end
    end

    # lead_times.write_attribute(build_attr_name(event_date,:am), )
    def build_attr_name date, time_period
      if date == Date.today
        case time_range
        when :am
          "next_am"
        when :pm
          "next_pm"
        else
          "next_ev"
        end
      else
        diff = (date - Date.today).to_i
        case time_range
        when :am
          "date_plus_#{diff.humanize}_next_pm"
        when :pm
          "date_plus_#{diff.humanize}_next_pm"
        else
          "date_plus_#{diff.humanize}_next_pm"
        end
      end
    end
  end
end
