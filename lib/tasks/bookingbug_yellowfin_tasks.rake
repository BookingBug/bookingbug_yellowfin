# TODO
# Doesn't work from cmd line for some reason
# NameError: uninitialized constant BookingbugYellowfin::BookingDetails
# /Users/joelsturmfels/repos/bookingbug_yellowfin/lib/tasks/bookingbug_yellowfin_tasks.rake:3:in `block in <top (required)>'
desc "Task to populate bookingbug_yellowfin tables for yellowfin BI"
task :populate_booking_details do
  BookingbugYellowfin::BookingDetails.populate_all_columns
end
