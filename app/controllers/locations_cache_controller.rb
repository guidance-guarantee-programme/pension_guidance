class LocationsCacheController < ActionController::Base
  before_action :token_authenticate

  def destroy
    BookingLocations.clear_cache

    head :no_content
  end

  private

  def token_authenticate
    authenticate_or_request_with_http_token do |token|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(locations_cache_token)
      )
    end
  end

  def locations_cache_token
    ENV.fetch('LOCATIONS_CACHE_TOKEN')
  end
end
