RSpec.feature 'Locale switching', type: :feature do
  scenario 'Switching from English to Welsh' do
    when_i_view_a_guide_in_english
    and_i_click_the_welsh_link
    then_i_am_on_the_welsh_article
  end

  scenario 'Viewing a welsh guide that has not been translated' do
    when_i_view_an_untranslated_welsh_article
    then_i_see_a_message_about_it_not_being_translated
  end

  scenario 'Visiting an address without a locale' do
    when_i_visit_an_address_without_a_locale
    then_i_am_redirect_to_the_address_in_the_default_locale
  end
end

def when_i_view_a_guide_in_english
  visit guide_path('tax', locale: :en)
end

def and_i_click_the_welsh_link
  page.find('.t-language-toggle').click
end

def then_i_am_on_the_welsh_article
  expect(current_path).to eq(guide_path('tax', locale: :cy))
end

def when_i_view_an_untranslated_welsh_article
  visit guide_path('appointments', locale: :cy)
end

def then_i_see_a_message_about_it_not_being_translated
  expect(page).to have_content('Ar hyn o bryd nid yw’r dudalen hon ar gael yn y Gymraeg')
end

def when_i_visit_an_address_without_a_locale
  visit '/tax'
end

def then_i_am_redirect_to_the_address_in_the_default_locale
  expect(current_path).to eq '/en/tax'
end
