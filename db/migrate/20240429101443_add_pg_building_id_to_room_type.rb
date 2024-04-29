class AddPgBuildingIdToRoomType < ActiveRecord::Migration[7.1]
  def change
    add_reference :room_types, :pg_building, null: false, foreign_key: true
  end
end
