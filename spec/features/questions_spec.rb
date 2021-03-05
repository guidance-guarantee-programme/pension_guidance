require 'spec_helper'

RSpec.feature 'Questions', type: :feature do
  def self.guides_with_questions
    GuideRepository.new.all.select do |guide|
      guide.content =~ /{::[^\s]+-question/m
    end
  end

  guides_with_questions.each do |guide|
    scenario "#{guide.id} correctly deal with no answer being provided" do
      visit "/#{guide.slug}"

      page.click_on 'Next step'

      expect(page.current_url).to match(guide.slug)
      expect(page).to have_content(I18n.t('pension_type_tool.error'))
    end
  end

  scenario 'can leave feedback' do
    visit '/pension-type-tool/question-1'

    expect(page).to have_content('Is there anything wrong with this page?')
  end

  scenario 'Errors are correctly described', js: true do
    visit '/en/pension-type-tool/question-1'

    click_on 'Accept all cookies'

    page.click_on('Next step')

    expect(page.find('.js-error-message')).to have_text
    expect(page).to have_css('.form-group-error')
  end
end
