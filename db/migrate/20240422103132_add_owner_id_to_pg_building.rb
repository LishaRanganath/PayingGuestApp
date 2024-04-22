class AddOwnerIdToPgBuilding < ActiveRecord::Migration[7.1]
  def change
    add_reference :pg_buildings, :owner, null: false, foreign_key: true
  end
end
