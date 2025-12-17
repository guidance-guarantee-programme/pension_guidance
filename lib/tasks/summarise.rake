# rubocop:disable Metrics/BlockLength
namespace :summarise do
  desc 'Produce PDF summary document variants'
  task pdfs: :environment do
    default = {
      appointment_type: 'standard',
      supplementary_benefits: true,
      supplementary_debt: true,
      supplementary_ill_health: true,
      supplementary_defined_benefit_pensions: true,
      supplementary_pension_transfers: false,
      urn: '',
      welsh: false
    }

    standard = AppointmentSummary.new(default)
    document = OutputDocument.new(standard, 'generic')
    document.pdf_file('./public/standard.pdf')

    standard_db = AppointmentSummary.new(default.dup.merge(supplementary_pension_transfers: true))
    document = OutputDocument.new(standard_db, 'generic')
    document.pdf_file('./public/standard-db.pdf')

    standard_welsh = AppointmentSummary.new(default.dup.merge(welsh: true))
    document = OutputDocument.new(standard_welsh, 'generic')
    document.pdf_file('./public/standard-cy.pdf')

    standard_db_welsh = standard_db.dup
    standard_db_welsh.welsh = true
    document = OutputDocument.new(standard_db_welsh, 'generic')
    document.pdf_file('./public/standard-db-cy.pdf')

    non_standard = AppointmentSummary.new(default.dup.merge(appointment_type: '50_54'))
    document = OutputDocument.new(non_standard, 'generic')
    document.pdf_file('./public/non-standard.pdf')

    non_standard_db = AppointmentSummary.new(
      default.dup.merge(
        appointment_type: '50_54',
        supplementary_pension_transfers: true
      )
    )
    document = OutputDocument.new(non_standard_db, 'generic')
    document.pdf_file('./public/non-standard-db.pdf')

    non_standard_cy = AppointmentSummary.new(
      default.dup.merge(
        appointment_type: '50_54',
        welsh: true
      )
    )
    document = OutputDocument.new(non_standard_cy, 'generic')
    document.pdf_file('./public/non-standard-cy.pdf')

    non_standard_db_cy = AppointmentSummary.new(
      default.dup.merge(
        appointment_type: '50_54',
        supplementary_pension_transfers: true,
        welsh: true
      )
    )
    document = OutputDocument.new(non_standard_db_cy, 'generic')
    document.pdf_file('./public/non-standard-db-cy.pdf')
  end
end
# rubocop:enable Metrics/BlockLength
