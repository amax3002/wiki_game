class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :start_point
      t.string :end_point

      t.timestamps
    end
  end
end
