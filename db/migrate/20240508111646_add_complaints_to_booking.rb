class AddComplaintsToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :complaints, :text
  end
end
