class BookingRequestMailerPreview < ActionMailer::Preview
  def booking_confirmation
    booking = BookingRequest.create!(
      first_name: 'Ben',
      last_name: 'Lovell',
      email: 'ben@example.com',
      telephone_number: '07715 930 455',
      memorable_word: 'snails',
      appointment_type: '55_or_over',
      opt_in: true,
      dc_pot: true
    )

    booking.slots_from(
      primary_slot: '2016-02-02-0800-1200',
      secondary_slot: '2016-02-05-1300-1700',
      tertiary_slot: '2016-02-10-0800-1200'
    )

    booking.save!

    BookingRequestMailer.customer_confirmation(booking)
  end
end
