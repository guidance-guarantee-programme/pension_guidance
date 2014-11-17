require 'govspeak'

module ActionView
  module Template::Handlers
    class Govspeak

      def call(template)
        document = ::Govspeak::Document.new(template.source)
        "'#{document.to_sanitized_html}'"
      end

    end
  end
end
