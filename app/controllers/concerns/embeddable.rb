module Embeddable
  extend ActiveSupport::Concern

  included do
    layout 'full_width_widget'

    skip_before_action :verify_authenticity_token
    after_action { response.headers.except! 'X-Frame-Options' }
  end
end
