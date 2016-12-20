class RolesUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_user do |t|
      t.integer "user_id"
      t.integer "role_id"
      t.timestamps
    end
  end
end
