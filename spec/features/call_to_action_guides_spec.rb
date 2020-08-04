require 'spec_helper'

RSpec.feature 'Call to action visible in specific guides' do
  scenario 'Pages without the tags do not display the CTA' do
    %w(
      /en/appointments
      /en/book-phone
      /en
      /en/tesco
      /en/cookies
      /en/divorce
    ).each do |path|
      visit path

      expect(page).to have_no_css('.t-cta')
    end
  end

  scenario 'Pages with the correct tags display the CTA' do
    %w(
      /en/browse/your-pension-details
      /en/browse/taking-your-pension-money
      /en/browse/tax-and-getting-advice
      /en/browse/illness-and-death
      /en/browse/more
      /en/pension-types
      /en/pension-statements
      /en/state-pension
      /en/pension-pot-value
      /en/making-money-last
      /en/transfer-pension
      /en/work-out-income
      /en/your-pension-before-55
      /en/scams
      /en/shop-around
      /en/tax
      /en/financial-advice
      /en/benefits
      /en/debt
      /en/ill-health
      /en/care-costs
      /en/when-you-die
      /en/living-abroad
      /en/protection
      /en/pension-recycling
      /en/pension-complaints
      /en/leave-pot-untouched
      /en/guaranteed-income
      /en/adjustable-income
      /en/take-cash-in-chunks
      /en/take-whole-pot
      /en/mix-options
    ).each do |path|
      visit path

      expect(page).to have_css('.t-cta')
    end
  end
end
