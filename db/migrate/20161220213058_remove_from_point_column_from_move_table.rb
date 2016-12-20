class RemoveFromPointColumnFromMoveTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :moves, :from_point
  end
end
