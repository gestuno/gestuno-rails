class ChangeCallsTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :calls, :interpreter
    remove_reference :calls, :customer

    add_reference :calls, :sender
    # add_column :calls, :recipient_id

    add_column :calls, :room_name, :string
    add_column :calls, :twilio_sid, :string
  end
end
