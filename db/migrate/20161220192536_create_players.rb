class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
