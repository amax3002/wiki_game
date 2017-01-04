class AddFromUrlToMoveTable < ActiveRecord::Migration[5.0]
  def change
    add_column :moves, :from_point, :string
    add_column :moves, :cheater, :boolean
  end
end
