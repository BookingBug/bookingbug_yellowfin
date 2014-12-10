module BookingbugYellowfin
  class LeadTimes < ActiveRecord::Base
    attr_accessible :date, :service_id, :next_am, :next_pm, :next_ev, :date_plus_one_next_am, :date_plus_one_next_pm, :date_plus_one_next_ev, :date_plus_two_next_am, :date_plus_two_next_pm, :date_plus_two_next_ev, :date_plus_three_next_am, :date_plus_three_next_pm, :date_plus_three_next_ev, :date_plus_four_next_am, :date_plus_four_next_pm, :date_plus_four_next_ev, :date_plus_five_next_am, :date_plus_five_next_pm, :date_plus_five_next_ev, :date_plus_six_next_am, :date_plus_six_next_pm, :date_plus_six_next_ev, :yf_format_date
# BookingbugYellowfin::LeadTimes.populate_lead_times
# BookingbugYellowfin::LeadTimes.
    def self.populate_lead_times
      p 'populate lead times'
      $stdout.sync = true
      failed = []
      for company in Company.where("cancelled != ? and template is null or template = ?", true, false)
        print '.'
        # Not needed for parent companies
        if ![37054, 37056, 37045, 36990].include?(company.base_company_id) && !company.is_parent
          begin
            self.add_lead_times_for_company company.id 
          rescue
            failed << company.id
          end
        end
      end
      ::BookingbugYellowfin::LeadTimeDays.populate_lead_time_days
      p ""
      p 'failed'
      p failed
    end

    def self.add_lead_times_for_company company_id
      # TODO localhost should look at the port number
      domain = (Rails.env.production? ? LOCAL_SETTINGS["site_domain"] : "localhost:3000" )
      for service in Service.where(company_id: company_id, deleted: false, disabled: false)
        sdate = ::Date.today
        edate = sdate + 1.week
        lead_times = self.where(date: sdate, service_id: service.id).first
        lead_times = self.new(date: sdate, service_id: service.id, yf_format_date: FormatHelpers.to_yf_format(sdate)) if lead_times.blank?
        nil_times = true
        cut_off_date = (service.max_advance_time.to_date + 1)
        while nil_times && sdate < cut_off_date
        protocol = (Rails.env.production? ? 'https' : "http" )
          uri = URI.parse("#{protocol}://#{domain}/api/v1/#{company_id}/time_data?date=#{sdate.iso8601}&end_date=#{edate}&num_resources=1&service_id=#{service.id}")
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
          request.add_field 'App-Id', '08f4a5e6'
          request.add_field 'App-Key', '6d6f6a0d11ccfe652b5ea94b5ad7deb6'
          request.add_field 'Bypass-Auth', 'true'
          http.use_ssl = true if Rails.env.production?
          response = http.request(request)
          data = JSON.parse(response.body)
          if data["error"].blank?
            events = data['_embedded']['events']
            for event in events
              next if lead_times.lead_times_found? ::Date.parse(event["date"])
              event_date = ::Date.parse(event["date"])
              days_diff = (event_date - ::Date.today).to_i
              times = event["times"]
              if times.present?
                for time in times
                  t = time["time"].to_i
                  if t < 720 && time["avail"] == 1
                    lead_times.time_found event_date, :am, service
                  elsif t >= 720 && t < 1020 && time["avail"] == 1
                    lead_times.time_found event_date, :pm, service
                  elsif t > 1020 && time["avail"] == 1
                    lead_times.time_found event_date, :ev, service
                  end
                  break if lead_times.lead_times_found? ::Date.parse(event["date"])
                end
              end
            end
          end
          nil_times = lead_times.nil_times?
          sdate = (edate + 1.day)
          edate = sdate + 1.week
          edate = cut_off_date if edate > cut_off_date
        end
        lead_times.save!
      end #close for
      true
    end

    def lead_times_found? date
      self.read_attribute(build_attr_name(date, :am)).present? &&
      self.read_attribute(build_attr_name(date, :pm)).present? &&
      self.read_attribute(build_attr_name(date, :ev)).present?
    end

    def time_found date, time_period, service
      days_diff = (date - ::Date.today).to_i
      if self.read_attribute(build_attr_name(date ,time_period)).nil? &&
        service.min_book_days <= days_diff
        self[build_attr_name(date ,time_period)] = days_diff
      end
    end

    def build_attr_name date, time_period
      BookingbugYellowfin::LeadTimes.build_attr_name date, time_period
    end

    def self.build_attr_name date, time_period
      if date == ::Date.today
        case time_period
        when :am
          "next_am"
        when :pm
          "next_pm"
        else
          "next_ev"
        end
      else
        diff = (date - ::Date.today).to_i
        case time_period
        when :am
          "date_plus_#{diff.humanize}_next_am"
        when :pm
          "date_plus_#{diff.humanize}_next_pm"
        else
          "date_plus_#{diff.humanize}_next_ev"
        end
      end
    end

    def next_wday (n)
      n > self.wday ? self + (n - self.wday) : self.next_week.next_day(n)
    end

    def nil_times?
      !(self.next_am && self.next_pm && self.next_ev && self.date_plus_one_next_am && self.date_plus_one_next_pm && 
            self.date_plus_one_next_ev && self.date_plus_two_next_am && self.date_plus_two_next_pm && self.date_plus_two_next_ev && 
            self.date_plus_three_next_am && self.date_plus_three_next_pm && self.date_plus_three_next_ev && self.date_plus_four_next_am && 
            self.date_plus_four_next_pm && self.date_plus_four_next_ev && self.date_plus_five_next_am && self.date_plus_five_next_pm && 
            self.date_plus_five_next_ev && self.date_plus_six_next_am && self.date_plus_six_next_pm && self.date_plus_six_next_ev)
    end
  end
end
