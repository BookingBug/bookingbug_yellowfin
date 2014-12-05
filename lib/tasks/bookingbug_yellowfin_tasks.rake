# TODO
# Doesn't work from cmd line for some reason
# NameError: uninitialized constant BookingbugYellowfin::BookingDetails
# /Users/joelsturmfels/repos/bookingbug_yellowfin/lib/tasks/bookingbug_yellowfin_tasks.rake:3:in `block in <top (required)>'
desc "Task to amend yesterdays bookings in bookingbug_yellowfin tables for yellowfin BI"
task :populate_booking_details => :environment do
  BookingbugYellowfin::BookingDetails.amend_yesterdays_bookings
end

desc "Task to populate all bookings for yellowfin BI"
task :populate_all_booking_details => :environment do
  BookingbugYellowfin::BookingDetails.populate_all_booking_details
end

desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :populate_lead_times => :environment do
  BookingbugYellowfin::LeadTimes.populate_lead_times
end

desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :populate_all_future_capacity_usage => :environment do
  BookingbugYellowfin::PersonCapacityFuture.populate_all_capacity_usage
end

desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :amend_yesterdays_capacity_usage => :environment do
  BookingbugYellowfin::PersonCapacityUsage.amend_yesterdays_capacity_usage
end

desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :populate_all_capacity_usage => :environment do
  BookingbugYellowfin::PersonCapacityUsage.populate_all_capacity_usage
end


desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :populate_four_months_forward => :environment do
  BookingbugYellowfin::Date.populate_four_months_forward
end