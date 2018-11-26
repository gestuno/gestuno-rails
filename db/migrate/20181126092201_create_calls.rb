class CreateCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :calls do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :interpreter # corresponds to user id
      t.references :customer # corresponds to user id

      t.timestamps
    end
  end
end
