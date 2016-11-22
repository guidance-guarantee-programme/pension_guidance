require 'govspeak'

Govspeak::Document.extension('calculator', %r(^{::calculator\sid="(?<id>.*?)"\s/})) do |id|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator hide-from-print"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial)

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end

regexp = %r${::ynm-question\sid="(?<id>.*?)"}(?<body>.*){:/ynm-question}$m
Govspeak::Document.extension('ynm-question', regexp) do |id, body|
  <<~FORM
    <form action="/pension-type" accept-charset="UTF-8" method="post" class="question-form">
      <input name="question_id" type="hidden" value="#{id}">
      #{Govspeak::Document.new(body.strip).to_html}
      <ul>
        <li class="question-form--option">
          <label for="response_0" class="question-form--label">
            <input type="radio" name="response" id="response_0" class="question-form--input" value="yes">
            Yes
          </label>
        </li>
        <li class="question-form--option">
          <label for="response_1" class="question-form--label">
            <input type="radio" name="response" id="response_1" class="question-form--input" value="no">
            No
          </label>
        </li>
        <li class="question-form--option">
          <label for="response_2" class="question-form--label">
            <input type="radio" name="response" id="response_2" class="question-form--input" value="dont_know">
            Don't know
          </label>
        </li>
      </ul>
      <div class="question-form--next-question">
        <button type="submit" class="medium button">Next step</button>
      </div>
    </form>
  FORM
end
