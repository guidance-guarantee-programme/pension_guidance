RSpec.describe 'Telephone appointment slot times partial', type: :view do
  it 'displays date and time information correcly' do
    slot_time = Time.zone.parse('1 January 2017 09:30')
    @telephone_appointment = double(selected_date: slot_time.to_date)

    render partial: 'telephone_appointments/times', locals: { times: [slot_time] }

    expect(rendered).to have_content('Choose a time on 1 January 2017')
    expect(rendered).to have_content('9:30am')
  end
end
