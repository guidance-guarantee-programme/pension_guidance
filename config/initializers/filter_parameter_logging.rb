# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
unless Rails.env.development?
  Rails.application.config.filter_parameters += %i[
    password
    email
    phone
    telephone_number
    memorable_word
    email_address
    phone_booking_message
    face_to_face_message
    other_message
  ]
end
