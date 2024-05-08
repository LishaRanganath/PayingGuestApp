class ChangeRoomBookingsToBookings < ActiveRecord::Migration[7.1]
  def change
    rename_table :room_bookings, :bookings
   end
end
