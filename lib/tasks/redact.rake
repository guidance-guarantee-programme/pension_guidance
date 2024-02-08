namespace :redact do
  desc 'Redact Pension Summaries older than 2 years'
  task pension_summaries: :environment do
    # rubocop:disable Rails/SkipsModelValidations
    PensionSummary.for_redaction.update_all(
      gender: 'redacted',
      name: 'redacted',
      age: 'redacted',
      email: 'redacted',
      country: 'redacted',
      comments: 'redacted'
    )
    # rubocop:enable Rails/SkipsModelValidations
  end
end
