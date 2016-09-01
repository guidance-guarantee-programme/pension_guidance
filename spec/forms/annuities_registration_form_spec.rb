RSpec.describe AnnuityRegistrationForm do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:phone_number) }
  it { is_expected.to validate_presence_of(:postcode) }
  it { is_expected.to validate_inclusion_of(:annuity_type).in_array(%w(in_own_name in_group_name dont_know)) }
  it { is_expected.to validate_numericality_of(:age).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:annuity_value).is_greater_than(0).allow_nil }

  context '.email' do
    it { is_expected.to allow_value('text@test.com').for(:email) }
    it { is_expected.to allow_value('  text@test.com  ').for(:email) }
    it { is_expected.not_to allow_value('text@ test .com').for(:email) }
  end
end
