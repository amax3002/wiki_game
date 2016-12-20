class CreatePagerenders < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :url

      t.timestamps
    end
  end
end
