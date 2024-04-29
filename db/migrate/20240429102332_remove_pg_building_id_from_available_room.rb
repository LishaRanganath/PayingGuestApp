class RemovePgBuildingIdFromAvailableRoom < ActiveRecord::Migration[7.1]
  def change
    remove_column :available_rooms, :pg_building_id, :integer
  end
end
