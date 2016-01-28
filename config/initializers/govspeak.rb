require 'govspeak'

Govspeak::Document.extension('calculator', %r(^{::calculator\sid="(?<id>.*?)"\s/})) do |id|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial)

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end
