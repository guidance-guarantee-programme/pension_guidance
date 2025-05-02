require 'govspeak'
require_relative '../../app/helpers/money_helper'

include MoneyHelper

regexp = %r(^{::calculator\sid="(?<id>.*?)"\slocale="(?<locale>.*?)"\s/})
Govspeak::Document.extension('calculator', regexp) do |id, locale|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator hide-from-print"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial, locals: { locale: locale })

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end

Govspeak::Document.extension('webchat', %r(^{::webchat\slocale="(?<locale>.*?)"/})) do |locale|
  ApplicationController.render(
    partial: 'components/webchat',
    locals: { locale: locale }
  )
end

Govspeak::Document.extension('money_helper_url', %r({::money_helper_url\spath="(?<path>.*?)"\slocale="(?<locale>.*?)"/})) do |path, locale| # rubocop:disable Layout/LineLength
  money_helper_url(path, locale: locale)
end
