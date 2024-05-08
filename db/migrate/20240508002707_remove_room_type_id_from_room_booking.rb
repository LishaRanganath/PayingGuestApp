class RemoveRoomTypeIdFromRoomBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :room_bookings, :room_type_id, :integer
  end
end
