module BookingbugYellowfin
  class BookingDetails < ActiveRecord::Base
    def self.populate_all_booking_details
      p 'Starting populate_all_booking_details...'
      $stdout.sync = true
      Company.find_each() do |company|
        (company.created_at.to_date..::Date.tomorrow).step(2) do |date|
          # p "start updating company: "+company.name
          total_bookings,new_bookings, updated_bookings, discarded_bookings = add_booking_details_for_company company.id, date, (date + 3.days)
          if new_bookings > 0 || updated_bookings > 0 || discarded_bookings > 0
            p "bookings for "+company.name+ " ON "+date.to_s+" ***TOTAL BOOKING FOUND:"+total_bookings.to_s+" ***ADDED: "+new_bookings.to_s+" ***UPDATED: "+updated_bookings.to_s+" *****DISCARDED: "+discarded_bookings.to_s
          else 
            p "No booking found for "+company.name+ " ON "+date.to_s
          end
        end
      end
    end

    # actually amends bookings from the last 2 days till tomorrow
    def self.amend_yesterdays_bookings
      p 'Starting amend_yesterdays_bookings...'
      $stdout.sync = true
      Company.find_each() do |company|
        print '.'
        add_booking_details_for_company company.id, 2.day.ago.to_date
      end
    end

    def self.add_booking_details_for_company company_id, sdate, edate = ::Date.tomorrow
      days = (::Date.today - sdate) if sdate
      e_days = (::Date.today - edate) if edate
      block = View::ReportsController::DATA_GROUPS[1][:reports][14]
      block[:date_field] = "updated_at"
      fields = View::ReportsController::DATA_GROUPS[1][:reports][14][:fields]
      p "********************** BOOKING "
      p "************************* FROM: "+ (Date.today - days).to_s
      p "*************************   TO: "+ (Date.today - e_days).to_s

      titles, rows = View::ReportsController.generate_report_data block,
                                                   company_id,
                                                   company_id.to_s,
                                                   {
                                                     :days=>days,
                                                     :e_days=>e_days, 
                                                     :fields=>fields
                                                   }
      booking_num = rows.size
      count_new = 0
      count_update = 0
      for row in rows
        if Purchase::Item.find_by_id(row[fields.find_index(:purchase_item_id)]).blank?
          p "purchase_item_id is blank for "+row.to_s
        end
        next if Purchase::Item.find_by_id(row[fields.find_index(:purchase_item_id)]).blank?
        record = BookingbugYellowfin::BookingDetails.where(
          booking_id: row[fields.find_index(:id)]
          ).first
        if record.present?
          record.update_attributes!( 
            booking_id: row[fields.find_index(:id)],
            slot_id: row[fields.find_index(:slot_id)],
            company_id: company_id,
            booking_created_at: row[fields.find_index(:created_at)],
            yf_format_booking_created_at: BookingbugYellowfin::FormatHelpers.to_yf_format(row[fields.find_index(:created_at)]), #yyyy/mm/dd
            member_id: row[fields.find_index(:member_id)],
            service: row[fields.find_index(:service_id)],
            resource: row[fields.find_index(:resource_id)],
            person: row[fields.find_index(:person_id)],
            session: row[fields.find_index(:session)],
            just_date: row[fields.find_index(:just_date)],
            yf_format_just_date: BookingbugYellowfin::FormatHelpers.to_yf_format(row[fields.find_index(:just_date)]),
            day_of_week: row[fields.find_index(:day_of_week)],
            month: row[fields.find_index(:month)],
            just_time: row[fields.find_index(:just_time)],
            duration: row[fields.find_index(:duration)],
            price: row[fields.find_index(:price)],
            paid: row[fields.find_index(:paid)],
            s_status: row[fields.find_index(:s_status)],
            coupon_code: row[fields.find_index(:coupon_code)],
            repeat_booking_id: row[fields.find_index(:repeat_booking_id)],
            purchase_item_id: row[fields.find_index(:purchase_item_id)],
            cancellation_date: row[fields.find_index(:cancellation_date)],
            late_cancel: row[fields.find_index(:late_cancel)],
            attended: row[fields.find_index(:attended)],
            channel: row[fields.find_index(:channel)],
            readable_current_multi_stat: row[fields.find_index(:readable_current_multi_stat)],
            notes: row[fields.find_index(:notes)],
            feedback: row[fields.find_index(:feedback)],
            pretty_print_multi_status: row[fields.find_index(:pretty_print_multi_status)]
          )
          count_update = count_update +1
        else
          BookingbugYellowfin::BookingDetails.create!( 
            booking_id: row[fields.find_index(:id)],
            slot_id: row[fields.find_index(:slot_id)],
            company_id: company_id,
            booking_created_at: row[fields.find_index(:created_at)],
            yf_format_booking_created_at: BookingbugYellowfin::FormatHelpers.to_yf_format(row[fields.find_index(:created_at)]), #yyyy/mm/dd
            member_id: row[fields.find_index(:member_id)],
            service: row[fields.find_index(:service_id)],
            resource: row[fields.find_index(:resource_id)],
            person: row[fields.find_index(:person_id)],
            session: row[fields.find_index(:session)],
            just_date: row[fields.find_index(:just_date)],
            yf_format_just_date: BookingbugYellowfin::FormatHelpers.to_yf_format(row[fields.find_index(:just_date)]),
            day_of_week: row[fields.find_index(:day_of_week)],
            month: row[fields.find_index(:month)],
            just_time: row[fields.find_index(:just_time)],
            duration: row[fields.find_index(:duration)],
            price: row[fields.find_index(:price)],
            paid: row[fields.find_index(:paid)],
            s_status: row[fields.find_index(:s_status)],
            coupon_code: row[fields.find_index(:coupon_code)],
            repeat_booking_id: row[fields.find_index(:repeat_booking_id)],
            purchase_item_id: row[fields.find_index(:purchase_item_id)],
            cancellation_date: row[fields.find_index(:cancellation_date)],
            late_cancel: row[fields.find_index(:late_cancel)],
            attended: row[fields.find_index(:attended)],
            channel: row[fields.find_index(:channel)],
            readable_current_multi_stat: row[fields.find_index(:readable_current_multi_stat)],
            notes: row[fields.find_index(:notes)],
            feedback: row[fields.find_index(:feedback)],
            pretty_print_multi_status: row[fields.find_index(:pretty_print_multi_status)]
          )
          count_new = count_new + 1
        end
      end
      discarded_bookings =  (booking_num - count_new - count_update)
      return booking_num,count_new,count_update,discarded_bookings
    end
  end
end