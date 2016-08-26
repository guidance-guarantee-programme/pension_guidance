class FeedbacksController < ApplicationController
  layout 'full_width'

  def new
    @booking_feedback = BookingFeedbackForm.new
  end

  def create
    @booking_feedback = BookingFeedbackForm.new(booking_feedback_params)

    ZenDesk.create_ticket(@booking_feedback.message_content) if @booking_feedback.valid?

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
    if @booking_feedback.valid?
      render_result :ok
    else
      render_result :bad_request
    end
  end

  def render_html_response
    if @booking_feedback.valid?
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
      .fetch(:booking_feedback, {})
      .permit(
        :name,
        :email,
        :message
      )
  end
end
