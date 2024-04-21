class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :phone
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
