class AddPgBuildingIdToCategory < ActiveRecord::Migration[7.1]
  def change
    add_reference :categories, :pg_building, null: false, foreign_key: true
  end
end
