class AddPgBuildingIdToAvailableRoom < ActiveRecord::Migration[7.1]
  def change
    add_reference :available_rooms, :pg_building, null: false, foreign_key: true
  end
end
