class FeedbacksController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'full_width'

  def new
    @feedback = FeedbackForm.new(booking_request_params)
  end

  def create
    @feedback = FeedbackForm.new(booking_feedback_params)

    ZenDesk.create_ticket(@feedback.message_content) if @feedback.valid?

    if request.xhr?
      render_xhr_response
    else
      render_html_response
    end
  end

  def thanks
  end

  private

  def render_xhr_response
    if @feedback.valid?
      render_result :ok
    else
      render_result :bad_request
    end
  end

  def render_html_response
    if @feedback.valid?
      redirect_to thanks_feedback_path
    else
      render :new
    end
  end

  def render_result(status)
    render partial: 'result', status: status
  end

  def booking_feedback_params
    params
      .fetch(:feedback, {})
      .permit(
        :name,
        :email,
        :message,
        :feedback_type
      )
  end
end
