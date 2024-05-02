class CreateRoomBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :room_bookings do |t|
      t.references :customer, null: true, foreign_key: true
      t.references :room_type, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.date :start_date
      t.references :duration, null: false, foreign_key: true
      t.integer :total_price
      t.integer :number_of_guests
      t.integer :number_of_rooms

      t.timestamps
    end
  end
end
