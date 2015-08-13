RSpec.feature 'Location analytics', type: :feature, js: true, vcr: true do
  def data_layer
    Array(page.evaluate_script('window.dataLayer')).reduce({}, :merge)
  end

  scenario 'Data available to the Google Tag Manage dataLayer' do
    visit '/locations/london'

    expect(data_layer).to include('locationId' => 'london')
  end

  scenario 'Search context available to the Google Tag Manage dataLayer' do
    visit '/locations/london?postcode=sw1a+1aa'

    expect(data_layer).to include('locationId' => 'london')
    expect(data_layer).to include('postcode' => 'SW1A 1AA')
    expect(data_layer).to include('distance' => '0.66')
    expect(data_layer).to include('position' => '1')
  end
end
