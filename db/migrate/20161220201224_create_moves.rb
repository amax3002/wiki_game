class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :player_id
      t.string :from_point
      t.string :to_point

      t.timestamps
    end
  end
end
