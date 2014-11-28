module BookingbugYellowfin
  class BookingDetails < ActiveRecord::Base
    def self.populate_all_booking_details
      Company.find_each() do |company|
        add_booking_details_for_company company.id, company.created_at.to_date
      end
    end

    def self.amend_yesterdays_bookings
      Company.find_each() do |company|
        add_booking_details_for_company company.id, 1.day.ago.to_date
      end
    end

    def self.add_booking_details_for_company company_id, sdate, edate = ::Date.tomorrow
      days = (::Date.today - sdate) if sdate
      e_days = (::Date.today - edate) if edate
      titles, rows = View::ReportsController.generate_report_data View::ReportsController::DATA_GROUPS[1][:reports][14],
                                                   company_id,
                                                   company_id.to_s,
                                                   {
                                                     :days=>days,
                                                     :e_days=>e_days, 
                                                     :fields=>View::ReportsController::DATA_GROUPS[1][:reports][14][:fields]
                                                   }
      for row in rows
        record = BookingbugYellowfin::BookingDetails.where( 
          booking_id: row[0]
          ).first
        if record.present?
          record.update_attributes( 
            booking_id: row[0],
            slot_id: row[1],
            company_id: company_id,
            booking_created_at: row[3],
            yf_format_booking_created_at: BookingbugYellowfin::FormatHelpers.to_yf_format(row[3]), #yyyy/mm/dd
            member_id: row[4],
            service: row[5],
            resource: row[6],
            person: row[7],
            session: row[8],
            just_date: row[9],
            yf_format_just_date: BookingbugYellowfin::FormatHelpers.to_yf_format(row[9]),
            day_of_week: row[10],
            month: row[11],
            just_time: row[12],
            duration: row[13],
            price: row[14],
            paid: row[15],
            s_status: row[16],
            coupon_code: row[17],
            repeat_booking_id: row[18],
            purchase_item_id: row[19],
            cancellation_date: row[20],
            late_cancel: row[21],
            attended: row[22],
            name: row[23],
            channel: row[24],
            readable_current_multi_stat: row[25],
            notes: row[26],
            feedback: row[27],
            pretty_print_multi_status: row[28]
          )
        else
          BookingbugYellowfin::BookingDetails.create( 
            booking_id: row[0],
            slot_id: row[1],
            company_id: company_id,
            booking_created_at: row[3],
            yf_format_booking_created_at: BookingbugYellowfin::FormatHelpers.to_yf_format(row[3]), #yyyy/mm/dd
            member_id: row[4],
            service: row[5],
            resource: row[6],
            person: row[7],
            session: row[8],
            just_date: row[9],
            yf_format_just_date: BookingbugYellowfin::FormatHelpers.to_yf_format(row[9]),
            day_of_week: row[10],
            month: row[11],
            just_time: row[12],
            duration: row[13],
            price: row[14],
            paid: row[15],
            s_status: row[16],
            coupon_code: row[17],
            repeat_booking_id: row[18],
            purchase_item_id: row[19],
            cancellation_date: row[20],
            late_cancel: row[21],
            attended: row[22],
            name: row[23],
            channel: row[24],
            readable_current_multi_stat: row[25],
            notes: row[26],
            feedback: row[27],
            pretty_print_multi_status: row[28]
          )
        end
      end
    end
  end
end