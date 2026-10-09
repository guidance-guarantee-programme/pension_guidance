require_relative 'face_to_face/api'

module FaceToFace
  module_function

  def create_booking(booking)
    api = FaceToFace::Api.new
    api.create_booking(booking.payload)
  end
end
