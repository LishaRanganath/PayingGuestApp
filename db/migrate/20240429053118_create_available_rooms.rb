class CreateAvailableRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :available_rooms do |t|
      t.references :pg_building, null: false, foreign_key: true
      t.references :room_type, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :room_price
      t.integer :availability

      t.timestamps
    end
  end
end
