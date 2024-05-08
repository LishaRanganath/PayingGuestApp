class RemoveCustomerIdFromRoomBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :room_bookings, :customer_id, :integer
  end
end
