class AddExistingAnnuityToBookingRequests < ActiveRecord::Migration
  def change
    add_column :booking_requests, :existing_annuity, :string
  end
end
