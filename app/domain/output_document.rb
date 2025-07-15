class OutputDocument
  attr_reader :appointment_summary, :variant

  delegate *SUPPLEMENTARY_OPTIONS, :appointment_type, :format_preference, :urn,
           to: :appointment_summary

  def initialize(appointment_summary, variant = 'generic_naked')
    @appointment_summary = appointment_summary
    @variant = variant
  end

  def next_steps?
    false
  end

  def welsh?
    false
  end

  def covering_letter_type
    ''
  end

  def html
    HTMLRenderer.new(self).render
  end

  def pdf
    Princely::Pdf.new.pdf_from_string(html)
  end
end
