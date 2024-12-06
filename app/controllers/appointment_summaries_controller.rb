# rubocop:disable Rails/OutputSafety
class AppointmentSummariesController < ApplicationController
  include Embeddable

  helper_method :appointment_type

  def new
    @appointment_summary = AppointmentSummary.new
  end

  def create
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)

    if @appointment_summary.valid?
      @content = content
    else
      render :new
    end
  end

  def download
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)

    return head :unprocessable_entity unless @appointment_summary.valid?

    output_document = OutputDocument.new(@appointment_summary, 'generic')

    send_data output_document.pdf,
              filename: 'pension_wise.pdf', type: 'application/pdf'
  end

  def print
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)
    output_document = OutputDocument.new(@appointment_summary, 'generic')

    @content = output_document.html.html_safe
  end

  private

  def content
    @content ||= Kramdown::Document.new(output_document, input: 'html').to_html.html_safe
  end

  def output_document
    @output_document = OutputDocument.new(@appointment_summary).html.html_safe
  end

  def appointment_summary_params
    params
      .require(:appointment_summary)
      .permit(
        *SUPPLEMENTARY_OPTIONS,
        :appointment_type,
        :urn
      )
  end

  def appointment_type
    appointment_summary_params[:appointment_type]
  end
end
# rubocop:enable Rails/OutputSafety
