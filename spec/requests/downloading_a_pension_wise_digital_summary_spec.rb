RSpec.describe 'Generating a Pension Wise Digital summary download', type: :request do
  specify 'Successfully generating the download without a URN' do
    post '/en/summary-document/download', params: {
      appointment_summary: {
        appointment_type: 'standard',
        supplementary_benefits: true,
        supplementary_debt: true,
        supplementary_ill_health: true,
        supplementary_defined_benefit_pensions: true,
        supplementary_pension_transfers: true
      }
    }

    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/pdf')
  end

  specify 'Successfully generating the download with a valid URN' do
    post '/en/summary-document/download', params: {
      appointment_summary: {
        urn: 'PMY9-0GCU',
        appointment_type: 'standard',
        supplementary_benefits: true,
        supplementary_debt: true,
        supplementary_ill_health: true,
        supplementary_defined_benefit_pensions: true,
        supplementary_pension_transfers: true
      }
    }

    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/pdf')
  end

  specify 'Attempting a download with an invalid URN' do
    post '/en/summary-document/download', params: {
      appointment_summary: {
        urn: 'PMY9-0GCUwhoopsies',
        appointment_type: 'standard',
        supplementary_benefits: true,
        supplementary_debt: true,
        supplementary_ill_health: true,
        supplementary_defined_benefit_pensions: true,
        supplementary_pension_transfers: true
      }
    }

    expect(response.status).to eq(422)
  end
end
