When(/^I visit the digital appointment summary generator$/) do
  @page = Pages::AppointmentSummaryGenerator.new
  @page.load
end

When(/^I select (.*) as my age range$/) do |age|
  generator = @page.generator

  case age
  when '55 or over' then generator.appointment_type_standard.set true
  when '50 to 54' then generator.appointment_type_50_54.set true
  end
end

When(/^I view the appointment summary$/) do
  generator = @page.generator
  generator.submit_button.click

  @page = Pages::AppointmentSummary.new
end

Given(/^I generate a valid appointment summary$/) do
  @page = Pages::AppointmentSummaryGenerator.new
  @page.load

  generator = @page.generator
  generator.appointment_type_standard.set true

  generator.submit_button.click

  @page = Pages::AppointmentSummary.new
end

When(/^I click the Save button$/) do
  @page.save_as_pdf_button.click
end

When(/^I click the Print button$/) do
  @page.print_button.click
end

Then(/^I see a link to the digital appointment summary page$/) do
  expect(@page).to have_appointment_summary_link
end

Then(/^I see a (.*) type appointment summary$/) do |age|
  expected_class = 't-summary-document--'

  case age
  when '55 or over' then expected_class += 'standard'
  when '50 to 54' then expected_class += '50_54'
  end

  expect(@page.document['class']).to include(expected_class)
end

Then(/^I should be presented with a PDF version$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  expect { PDF::Inspector::Text.analyze(page.source) }.not_to raise_error
end

Then(/^I should see a print friendly document$/) do
  expect(@page).not_to have_footer
end

Given(/^I want extra information about "([^"]*)"$/) do |topic|
  @page = Pages::AppointmentSummaryGenerator.new
  @page.load

  generator = @page.generator

  case topic
  when 'How my pension effects my benefits' then
    generator.supplementary_benefits.set true
  when 'Getting help with debt' then
    generator.supplementary_debt.set true
  when 'Taking my pension if I have ill health' then
    generator.supplementary_ill_health.set true
  when 'Final salary or career average pensions' then
    generator.supplementary_defined_benefit_pensions.set true
  when 'Transfer pension pot'
    generator.supplementary_pension_transfers.set true
  end
end

Then(/^it should include extra information about "(.*?)"$/) do |topic|
  supplementary_section = case topic
                          when 'How my pension effects my benefits' then
                            'benefits'
                          when 'Getting help with debt' then
                            'debt'
                          when 'Taking my pension if I have ill health' then
                            'ill health'
                          when 'Final salary or career average pensions' then
                            'defined benefit pensions'
                          when 'Transfer pension pot'
                            'pension transfer'
                          end

  expect(@page.source).to include("<!-- section: #{supplementary_section} -->")
end
