class AddAvailableRoomIdToRoomBooking < ActiveRecord::Migration[7.1]
  def change
    add_reference :room_bookings, :available_room, null: false, foreign_key: true
  end
end
