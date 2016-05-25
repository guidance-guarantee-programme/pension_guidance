class CreateBookingRequests < ActiveRecord::Migration
  def change
    create_table :booking_requests do |t|
      t.string :reference_number
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone_number
      t.string :memorable_word
      t.string :appointment_type
      t.boolean :opt_in
      t.boolean :dc_pot
      t.string :location_id

      t.timestamps null: false
    end
  end
end
