class AppointmentFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &_block)
    if block_given?
      super + yield
    else
      errors = @object.errors[method]

      @template.content_tag(:label, options) do
        tag = @template.content_tag(:span, text, class: 'form-label-bold')
        tag << @template.content_tag(:span, errors.join(', '), class: 'error-message') if errors.present?
        tag
      end
    end
  end

  def form_group(method, &_block)
    tag_classes = [].tap do |classes|
      classes << 'form-group'
      classes << 'error' if @object.errors[method].any?
    end

    @template.content_tag(:div, class: tag_classes.join(' ')) do
      yield
    end
  end
end
