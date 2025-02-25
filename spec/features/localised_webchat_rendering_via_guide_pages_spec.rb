require 'spec_helper'

RSpec.describe 'Rendering localised webchat links', type: :feature do
  scenario 'Rendering the :en equivalent' do
    visit '/en/pension-type-tool'

    expect(page.find('.t-webchat')).to have_text('Need help? Live chat with our specialists')
  end

  scenario 'Rendering the :cy equivalent' do
    visit '/cy/pension-type-tool'

    expect(page.find('.t-webchat')).to have_text('Angen help? Sgyrsiwch yn fyw gyda’n harbenigwyr')
  end
end
