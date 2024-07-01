class CspReportsController < ActionController::Base # rubocop:disable Rails/ApplicationController
  def create
    if ENV['LOG_CSP_REPORTS']
      report = JSON.parse(request.body.read)
      logger.info(report)
    end

    head :ok
  end
end
