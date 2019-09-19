require_relative '../../features/pages/guide_page'
require_relative '../../features/pages/home_page'
require_relative '../../features/pages/new_referral'
require_relative '../../features/pages/edit_referral'

RSpec.feature 'Agent referral from a pension provider' do
  scenario 'Opening and closing a referral' do
    given_the_user_is_identified_as_an_agent do
      and_pension_providers_are_configured do
        when_the_agent_visits_the_site
        and_they_log_an_in_progress_referral
        then_they_see_the_referral_particulars
        when_they_add_an_outcome
        then_the_referral_is_logged
      end
    end
  end

  scenario 'Attempting to visit as a non-agent' do
    when_the_user_visits_the_site
    then_they_do_not_see_the_banner
    when_they_attempt_to_visit_the_referral_page
    then_they_are_not_authorised
  end

  def given_the_user_is_identified_as_an_agent
    ENV['I_AM_AN_AGENT'] = 'true'
    yield
  ensure
    ENV.delete('I_AM_AN_AGENT')
  end

  def and_pension_providers_are_configured
    ENV['PENSION_PROVIDERS'] = { 'aviva' => 'Aviva', 'hg' => 'Hargreaves Landsdown' }.to_json
    yield
  ensure
    ENV.delete('PENSION_PROVIDERS')
  end

  def when_the_agent_visits_the_site
    @page = Pages::Home.new
    @page.load
  end

  def and_they_log_an_in_progress_referral # rubocop:disable AbcSize
    expect(@page).to have_referrer_banner
    @page.referrer_banner.assign.click

    @page = Pages::NewReferral.new
    expect(@page).to be_displayed

    @page.surname.set('Jones')
    @page.provider.select('Aviva')
    @page.date_of_birth_day.set('02')
    @page.date_of_birth_month.set('02')
    @page.date_of_birth_year.set('1965')
    @page.submit.click
  end

  def then_they_see_the_referral_particulars
    @page = Pages::Guide.new
    expect(@page).to be_displayed
    expect(@page).to have_content('Jones')
    expect(@page).to have_content('Aviva')
    expect(@page).to have_content('2 February 1965')
  end

  def when_they_add_an_outcome
    @page.call_outcome.click

    @page = Pages::EditReferral.new
    expect(@page).to be_displayed

    @page.call_outcome.select('Appointment booked')
    @page.submit.click
  end

  def then_the_referral_is_logged
    expect(Referral.last).to have_attributes(
      surname: 'Jones',
      pension_provider: 'aviva',
      date_of_birth: '1965-02-02'.to_date,
      call_outcome: 'Appointment booked'
    )
  end

  def when_the_user_visits_the_site
    @page = Pages::Home.new
    @page.load
  end

  def then_they_do_not_see_the_banner
    expect(@page).to have_no_referrer_banner
  end

  def when_they_attempt_to_visit_the_referral_page
    @page = Pages::NewReferral.new
    @page.load
  end

  def then_they_are_not_authorised
    expect(@page.status_code).to eq(401)
  end
end
