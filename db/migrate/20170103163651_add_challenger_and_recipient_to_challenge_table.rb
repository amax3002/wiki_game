class AddChallengerAndRecipientToChallengeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :challenger_id, :integer
    add_column :challenges, :recipient_id, :integer
    add_column :challenges, :recipient_email, :string
    add_column :challenges, :recipient_name, :string
  end
end
