require 'govspeak'

module ActionView
  module Template::Handlers
    class Govspeak

      def call(template)
        govspeak = ::Govspeak::Document.new(template.source)
        govspeak.to_sanitized_html.inspect
      end

    end
  end
end
