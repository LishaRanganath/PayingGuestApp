class CreateDurations < ActiveRecord::Migration[7.1]
  def change
    create_table :durations do |t|
      t.string :name
      t.integer :number_of_days

      t.timestamps
    end
  end
end
