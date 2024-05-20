namespace :export do
  desc 'Export CSV data to blob storage for analysis'
  task blob: :environment do
    from_timestamp = ENV.fetch('FROM') { 3.months.ago }

    PensionSummary.public_send(:acts_as_copy_target)

    data = PensionSummary
           .where('created_at >= ? or updated_at >= ?', from_timestamp, from_timestamp)
           .select(
             'id, leave_your_pot_untouched, get_a_guaranteed_income, take_cash, take_whole,
             mix_your_options, how_my_pension_affects_my_benefits, getting_help_with_debt,
             taking_my_pension_if_im_ill, transferring_my_pension_to_another_provider
             scams, how_my_pension_is_taxed, final, gender, age, consent_given,
             country, created_at, updated_at, generated_at, final_salary_career_average'
           ).order(:created_at).copy_to_string

    client = Azure::Storage::Blob::BlobService.create_from_connection_string(
      ENV.fetch('AZURE_CONNECTION_STRING')
    )

    client.create_block_blob(
      'pw-prd-data',
      "/To_Be_Processed/MAPS_PWBLZ_PENSIONSUM_#{Time.current.strftime('%Y%m%d%H%M%S')}.csv",
      data
    )
  end
end
