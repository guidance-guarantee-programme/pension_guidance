# rubocop:disable Layout/LineLength
RSpec.describe PensionSummary::StepViewing, type: :model do
  subject { FactoryBot.build(:pension_summary_step_viewing) }

  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(primary: true) }
    it { is_expected.to have_db_column(:step).of_type(:string).with_options(limit: 100, null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }

    it { is_expected.to belong_to(:pension_summary) }
  end

  describe 'default scope' do
    let!(:pension_summary) { FactoryBot.create(:pension_summary, :generated) }
    let!(:step_viewing_1) { FactoryBot.create(:pension_summary_step_viewing, pension_summary: pension_summary, step: 'scams', created_at: 2.weeks.ago) }
    let!(:step_viewing_2) { FactoryBot.create(:pension_summary_step_viewing, pension_summary: pension_summary, step: 'final', created_at: 1.week.ago) }
    let!(:step_viewing_3) { FactoryBot.create(:pension_summary_step_viewing, pension_summary: pension_summary, step: 'how_my_pension_is_taxed', created_at: 3.weeks.ago) }

    it 'is sorted by created_at' do
      expect(described_class.all).to eq([step_viewing_3, step_viewing_1, step_viewing_2])
    end
  end
end
# rubocop:enable Layout/LineLength
