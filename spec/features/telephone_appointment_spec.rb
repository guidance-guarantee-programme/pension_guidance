RSpec.feature 'Customer books a telephone appointment', type: :feature do
  scenario 'Refreshing their confirmation' do
    # visit without required params
    visit confirmation_telephone_appointments_path(locale: :en)

    expect(page.current_path).to eq(root_path(locale: :en))
  end
end
