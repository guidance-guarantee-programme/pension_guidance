class ErrorsController < ApplicationController
  include Gaffe::Errors
  include Embeddable

  def show
    render "errors/#{@rescue_response}", status: @status_code
  end
end
