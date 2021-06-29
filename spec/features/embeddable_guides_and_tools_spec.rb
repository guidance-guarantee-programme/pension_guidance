require 'spec_helper'

RSpec.feature 'Embeddable guides and tools' do
  scenario 'Pages are embeddable when tagged as such' do
    @guides = GuideRepository.new.all.select(&:embeddable?)

    @guides.each do |guide|
      visit "/#{guide.locale}/#{guide.slug}"

      expect(page).to have_no_css('.l-masthead') # branding
      expect(page).to have_no_css('.skiplink')
      expect(page).to have_no_css('#global-cookie-message')
    end
  end
end
