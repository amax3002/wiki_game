class RemoveGameColumnIdToMoveForQuickFix < ActiveRecord::Migration[5.0]
  def change
    remove_column :moves, :which_game
  end
end
