class RemoveCategoryIdFromRoomBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :room_bookings, :category_id, :integer
  end
end
