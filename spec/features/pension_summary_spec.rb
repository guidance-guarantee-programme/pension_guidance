# rubocop:disable Metrics/LineLength
RSpec.feature 'The pension summary', type: :feature do
  context 'When pilot summaries are enabled' do
    scenario 'Viewing the complete pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_false
      and_pilot_summaries_are_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end

    scenario 'Viewing the pilot pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_true
      and_pilot_summaries_are_enabled
      and_pilot_data_collection_is_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
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
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end

    scenario 'Viewing the pilot pension summary is not possible' do
      given_the_pilot_summaries_cookie_is_set_to_true
      and_pilot_summaries_are_disabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end
  end

  context 'When pilot summaries enforced' do
    scenario 'Viewing the old summary is not possible in English' do
      given_the_pilot_summaries_cookie_is_set_to_false
      and_pilot_summaries_are_enabled
      and_pilot_summaries_are_enforced
      and_pilot_data_collection_is_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_answer_the_questions_about_me
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      and_i_view_a_summary_with_all_pages
      and_i_fill_out_the_your_experience_form
      then_i_view_a_thank_you_page
    end

    scenario 'Viewing the old summary is possible in Welsh' do
      given_the_pilot_summaries_cookie_is_set_to_false
      and_pilot_summaries_are_enabled
      and_pilot_summaries_are_enforced
      and_pilot_data_collection_is_enabled

      when_i_am_on_the_home_page(locale: 'cy')
      and_i_choose_to_explore_my_pension_options
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      then_i_view_a_summary_with_all_pages
    end

    scenario 'Viewing the pilot pension summary' do
      given_the_pilot_summaries_cookie_is_set_to_true
      and_pilot_summaries_are_enabled
      and_pilot_summaries_are_enforced
      and_pilot_data_collection_is_enabled

      when_i_am_on_the_home_page
      and_i_choose_to_explore_my_pension_options
      and_i_answer_the_questions_about_me
      and_i_select_all_pension_options
      and_i_select_all_extra_options
      and_i_view_a_summary_with_all_pages
      and_i_fill_out_the_your_experience_form
      then_i_view_a_thank_you_page
    end

    context 'and data collection is disabled' do
      scenario 'Viewing the pilot pension summary' do
        given_the_pilot_summaries_cookie_is_set_to_true
        and_pilot_summaries_are_enabled
        and_pilot_summaries_are_enforced
        and_pilot_data_collection_is_disabled

        when_i_am_on_the_home_page
        and_i_choose_to_explore_my_pension_options
        and_i_select_all_pension_options
        and_i_select_all_extra_options
        and_i_view_a_summary_with_all_pages
        and_i_fill_out_the_your_experience_form
        then_i_view_a_thank_you_page
      end
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

def and_pilot_summaries_are_enforced
  allow(ENV).to receive(:[]).and_call_original
  allow(ENV).to receive(:[]).with('FORCE_PILOT_SUMMARIES').and_return('true')
end

def and_pilot_data_collection_is_enabled
  allow(ENV).to receive(:[]).with('PILOT_DATA_COLLECTION').and_return('true')
end

def and_pilot_data_collection_is_disabled
  allow(ENV).to receive(:[]).with('PILOT_DATA_COLLECTION').and_return(nil)
end

def when_i_am_on_the_home_page(locale: 'en')
  visit("/#{locale}")
end

def and_i_choose_to_explore_my_pension_options
  if I18n.locale == :cy
    visit '/cy/explore-your-options'
  else
    visit '/en/explore-your-options'
  end
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

def and_i_select_all_pension_options # rubocop:disable Metrics/MethodLength
  if I18n.locale == :cy
    checkboxes = [
      'Gadael eich cronfa heb ei gyffwrdd',
      'Cael incwm gwarantedig (blwydd-dal)',
      'Cael incwm addasadwy',
      'Cymryd arian allan fesul tipyn',
      'Cymryd eich cronfa gyfan ar un tro',
      'Cymysgu eich opsiynau'
    ]

    next_button = 'Nesaf'
  else
    checkboxes = [
      'Leave your pot untouched',
      'Get a guaranteed income (annuity)',
      'Get an adjustable income',
      'Take cash in chunks',
      'Take your whole pot in one go',
      'Mix your options'
    ]

    next_button = 'Next'
  end

  checkboxes.each { |checkbox| check(checkbox) }
  click_button(next_button)
end

def and_i_select_all_extra_options # rubocop:disable Metrics/MethodLength
  if I18n.locale == :cy
    checkboxes = [
      'Sut mae fy mhensiwn yn effeithio ar fy mudd-daliadau',
      'Cael help gyda dyled',
      'Cymryd fy mhensiwn os wyf yn sâl',
      'Trosglwyddo fy mhensiwn i ddarparwr arall'
    ]

    next_button = 'Nesaf'
  else
    checkboxes = [
      'How my pension affects my benefits',
      'Getting help with debt',
      'Taking my pension if I’m ill',
      'Transferring my pension to another provider'
    ]

    next_button = 'Next'
  end

  checkboxes.each { |checkbox| check(checkbox) }
  click_button(next_button)
end

def then_i_view_a_summary_with_all_pages # rubocop:disable Metrics/MethodLength
  if I18n.locale == :cy
    titles = [
      'Gadael eich cronfa heb ei gyffwrdd',
      'Cael incwm gwarantedig (blwydd-dal)',
      'Cael incwm addasadwy',
      'Cymryd arian allan fesul tipyn',
      'Cymryd eich cronfa gyfan ar un tro',
      'Cymysgu eich opsiynau',
      'Treth rydych yn ei dalu ar eich pensiwn',
      'Sgamiau pensiwn',
      'Budd-daliadau ac incwm o bensiwn',
      'Dyled a phensiynau',
      'Pensiynau a salwch',
      'Trosglwyddiadau penswn',
      'Arweiniad pellach diduedd am ddim'
    ]

    next_button = 'Nesaf'
  else
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

    next_button = 'Next'
  end

  titles.each do |title|
    expect(page).to have_content(title)
    click_link(next_button) unless title == titles.last
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
