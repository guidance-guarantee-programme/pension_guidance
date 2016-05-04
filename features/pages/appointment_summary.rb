module Pages
  class AppointmentSummary < Page
    set_url_matcher %r{/summary-generator}

    element :document, '.t-summary-document'
    element :save_as_pdf_button, '.t-save-summary-as-pdf'
    element :print_button, '.t-print-summary'
  end
end
