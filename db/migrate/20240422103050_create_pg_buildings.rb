class CreatePgBuildings < ActiveRecord::Migration[7.1]
  def change
    create_table :pg_buildings do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :image

      t.timestamps
    end
  end
end
