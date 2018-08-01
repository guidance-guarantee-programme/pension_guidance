RSpec.feature 'The pension summary', type: :feature do
  scenario 'Viewing the complete pension summary' do
    when_i_am_on_the_home_page
    and_i_choose_to_explore_my_pension_options
    and_i_begin_the_questionnaire
    and_i_select_all_pension_options
    and_i_select_all_extra_options
    then_i_view_a_summary_with_all_pages
  end
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
