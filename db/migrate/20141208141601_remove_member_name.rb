class RemoveMemberName < ActiveRecord::Migration
  def up
    remove_column :bookingbug_yellowfin_booking_details, :name
  end

  def down
    add_column :bookingbug_yellowfin_booking_details, :name, :string
  end
end
