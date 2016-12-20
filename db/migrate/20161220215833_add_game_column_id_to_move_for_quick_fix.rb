class AddGameColumnIdToMoveForQuickFix < ActiveRecord::Migration[5.0]
  def change
    add_column :moves, :which_game, :string
  end
end
