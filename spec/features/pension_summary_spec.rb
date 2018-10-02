# rubocop:disable Metrics/LineLength
RSpec.feature 'The pension summary', type: :feature do
  context 'When pilot summaries are enabled' do
    scenario 'Viewing the complete pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_false
      and_pilot_summaries_are_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_begin_the_questionnaire
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end

    scenario 'Viewing the pilot pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_true
      and_pilot_summaries_are_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_begin_the_questionnaire
      and_i_answer_the_questions_about_me
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      and_i_view_a_summary_with_all_pages
      and_i_fill_out_the_your_experience_form
      then_i_view_a_thank_you_page
    end
  end

  context 'When pilot summaries are disabled' do
    scenario 'Viewing the complete pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_false
      and_pilot_summaries_are_disabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_begin_the_questionnaire
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end

    scenario 'Viewing the pilot pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_true
      and_pilot_summaries_are_disabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_begin_the_questionnaire
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end
  end
end

def given_the_pilot_summaries_cookie_is_set_to_false
  page.driver.browser.set_cookie('pilot_summaries=false')
end

def given_the_pilot_summaries_cookie_is_set_to_true
  page.driver.browser.set_cookie('pilot_summaries=true')
end

def and_pilot_summaries_are_enabled
  allow(ENV).to receive(:[]).and_call_original
  allow(ENV).to receive(:[]).with('PILOT_SUMMARIES').and_return('true')
end

def and_pilot_summaries_are_disabled
  allow(ENV).to receive(:[]).and_call_original
  allow(ENV).to receive(:[]).with('PILOT_SUMMARIES').and_return(nil)
end

def when_i_am_on_the_home_page
  visit('/')
end

def and_i_choose_to_explore_my_pension_options
  click_link('Explore your options')
end

def and_i_begin_the_questionnaire
  click_button('Start now')
end

def and_i_answer_the_questions_about_me
  check('I give my consent for my contact details to be shared with Ipsos MORI for this purpose')
  fill_in('Name', with: 'Jim Bob')
  fill_in('Email', with: 'jim@bob.com')
  choose('Male')
  choose('Under 50')
  choose('England')
  click_button('Next')
end

def and_i_select_all_pension_options
  check('Leave your pot untouched')
  check('Get a guaranteed income (annuity)')
  check('Get an adjustable income')
  check('Take cash in chunks')
  check('Take your whole pot in one go')
  check('Mix your options')
  click_button('Next')
end

def and_i_select_all_extra_options
  check('How my pension affects my benefits')
  check('Getting help with debt')
  check('Taking my pension if I’m ill')
  check('Transferring my pension to another provider')
  click_button('Next')
end

def then_i_view_a_summary_with_all_pages # rubocop:disable Metrics/MethodLength
  titles = [
    'Leave your pot untouched',
    'Get a guaranteed income (annuity)',
    'Get an adjustable income',
    'Take cash in chunks',
    'Take your whole pot in one go',
    'Mix your options',
    'Tax you pay on your pension',
    'Scams',
    'How my pension affects my benefits',
    'Getting help with debt',
    'Taking my pension if I’m ill',
    'Transferring my pension to another provider',
    'Further free and impartial guidance'
  ]

  titles.each do |title|
    expect(page).to have_content(title)
    click_link('Next') unless title == titles.last
  end
end

def and_i_view_a_summary_with_all_pages
  then_i_view_a_summary_with_all_pages
  click_link('Next')
end

def and_i_fill_out_the_your_experience_form
  choose('Very satisfied')
  fill_in('Please let us know anything that has made you particularly satisfied or dissatisfied with the Pension Wise service:', with: 'Everything was great')
  select('TV advert', from: 'Where did you first hear of Pension Wise?')
  click_button('Next')
end

def then_i_view_a_thank_you_page
  expect(page).to have_content('Thank you')
end
