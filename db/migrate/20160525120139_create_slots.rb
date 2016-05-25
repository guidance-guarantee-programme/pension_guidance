class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :position
      t.date :chosen_date
      t.string :name
      t.integer :booking_request_id

      t.timestamps null: false
    end
  end
end
