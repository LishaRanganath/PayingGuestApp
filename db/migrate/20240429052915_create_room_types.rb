class CreateRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
