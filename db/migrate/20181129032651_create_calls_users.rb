class CreateCallsUsers < ActiveRecord::Migration[5.2]
  # join table for call recipients
  def change
    create_table :calls_users do |t|
      t.references :call
      t.references :user

      t.timestamps
    end
  end
end
