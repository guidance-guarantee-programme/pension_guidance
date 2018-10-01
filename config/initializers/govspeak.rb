require 'govspeak'

regexp = %r(^{::calculator\sid="(?<id>.*?)"\slocale="(?<locale>.*?)"\s/})
Govspeak::Document.extension('calculator', regexp) do |id, locale|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator hide-from-print"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial, locals: { locale: locale })

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end

# Example:
#   {::yes-no-dont-know-question id="pension_type_question_1" locale="en"}
#   ## Was your pension set up by your employer?
#   {:/yes-no-dont-know-question}
#
# partial_name = yes-no-dont-know-question
# id = pension_type_question_1
# header = '## Was your pension set up by your employer?'
regexp = %r${::(?<partial_name>[^\s]+-question)\sid="(?<id>.*?)"\slocale="(?<locale>.*?)"}(?<header>.*){:/\k<partial_name>}$m # rubocop:disable Metrics/LineLength
Govspeak::Document.extension('multi-choice-questions', regexp) do |partial_name, id, locale, header|
  partial = "questions/#{partial_name.tr('-', '_')}"

  ApplicationController.new.render_to_string(
    partial: partial,
    locals: {
      id: id,
      locale: locale,
      header: Govspeak::Document.new(header.strip).to_html.html_safe # rubocop:disable Rails/OutputSafety
    }
  )
end

Govspeak::Document.extension('feedback', %r(^{::feedback_form /})) do
  partial = 'feedbacks/feedback_form'

  feedback = FeedbackForm.new(feedback_type: 'pension_type_tool')

  ApplicationController.render(
    partial: partial,
    assigns: { feedback: feedback }
  )
end

Govspeak::Document.extension('webchat', %r(^{::webchat /})) do
  ApplicationController.render(partial: 'components/webchat')
end
