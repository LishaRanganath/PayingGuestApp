class AddPaymentStatusToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :booking_status, :string
  end
end
