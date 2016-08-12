class OutputDocument
  class HTMLRenderer
    include ActionView::Helpers::TextHelper

    attr_reader :output_document

    def initialize(output_document)
      @output_document = output_document
    end

    def render
      template.render(output_document)
    end

    private

    def template
      template_id = output_document.variant == 'other' ? 'ineligible' : output_document.variant

      Output::Templates.template(template_id)
    end
  end
end
