# rubocop:disable Metrics/LineLength
RSpec.describe PensionSummary, type: :model do
  subject { FactoryBot.build(:pension_summary) }

  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:uuid).with_options(primary: true) }

    it { is_expected.to have_db_column(:leave_your_pot_untouched).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:get_a_guaranteed_income).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:get_an_adjustable_income).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:take_cash).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:take_whole).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:mix_your_options).of_type(:boolean).with_options(null: false, default: false) }

    it { is_expected.to have_db_column(:how_my_pension_affects_my_benefits).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:getting_help_with_debt).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:taking_my_pension_if_im_ill).of_type(:boolean).with_options(null: false, default: false) }
    it { is_expected.to have_db_column(:transferring_my_pension_to_another_provider).of_type(:boolean).with_options(null: false, default: false) }

    it { is_expected.to have_db_column(:scams).of_type(:boolean).with_options(null: false, default: true) }
    it { is_expected.to have_db_column(:how_my_pension_is_taxed).of_type(:boolean).with_options(null: false, default: true) }
    it { is_expected.to have_db_column(:final).of_type(:boolean).with_options(null: false, default: true) }

    it { is_expected.to have_db_column(:generated_at).of_type(:datetime).with_options(null: true) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe '#generated?' do
    context 'when the summary has not been generated' do
      it { is_expected.not_to be_generated }
    end

    context 'when the summary has been generated' do
      subject { FactoryBot.build(:pension_summary, :generated) }

      it { is_expected.to be_generated }
    end
  end

  describe '#steps' do
    it 'returns a hash of steps' do
      expect(subject.steps).to match(
        hash_including(
          'final' => true,
          'get_a_guaranteed_income' => false,
          'get_an_adjustable_income' => false,
          'getting_help_with_debt' => false,
          'how_my_pension_affects_my_benefits' => false,
          'how_my_pension_is_taxed' => true,
          'leave_your_pot_untouched' => false,
          'mix_your_options' => false,
          'scams' => true,
          'take_cash' => false,
          'take_whole' => false,
          'taking_my_pension_if_im_ill' => false,
          'transferring_my_pension_to_another_provider' => false
        )
      )
    end

    it 'removes other attributes' do
      expect(subject.steps).to match(
        hash_not_including(
          'id' => a_value,
          'generated_at' => a_value,
          'created_at' => a_value,
          'updated_at' => a_value
        )
      )
    end
  end

  describe '#selected_steps' do
    it 'returns an array of selected steps' do
      expect(subject.selected_steps).to eq(%w(how_my_pension_is_taxed scams final))
    end
  end

  describe '#current_step' do
    context 'when the current step has not been set' do
      it 'returns the first step' do
        expect(subject.current_step).to eq('how_my_pension_is_taxed')
      end
    end

    context 'when the current step has been set' do
      before do
        subject.instance_variable_set(:@current_step, 'final')
      end

      it 'returns the first step' do
        expect(subject.current_step).to eq('final')
      end
    end
  end

  describe '#current_step=' do
    subject { FactoryBot.create(:pension_summary, :generated) }

    context 'when the step has been selected' do
      it 'sets the current step' do
        expect { subject.current_step = 'scams' }.to change { subject.instance_variable_get(:@current_step) }.from(nil).to('scams')
      end
    end

    context 'when the step has not been selected' do
      it 'sets the current step to the first step' do
        expect { subject.current_step = 'take_cash' }.to change { subject.instance_variable_get(:@current_step) }.from(nil).to('how_my_pension_is_taxed')
      end
    end

    context 'when the step is invalid' do
      it 'sets the current step to the first step' do
        expect { subject.current_step = 'unknown_step' }.to change { subject.instance_variable_get(:@current_step) }.from(nil).to('how_my_pension_is_taxed')
      end
    end
  end

  describe '#current_step_number' do
    before do
      subject.instance_variable_set(:@current_step, 'scams')
    end

    it 'returns the current step number using 1-based index' do
      expect(subject.current_step_number).to eq(2)
    end
  end

  describe '#first_step?' do
    context 'when the current step is the first step' do
      before do
        subject.instance_variable_set(:@current_step, 'how_my_pension_is_taxed')
      end

      it { is_expected.to be_first_step }
    end

    context 'when the current step is not the first step' do
      before do
        subject.instance_variable_set(:@current_step, 'scams')
      end

      it { is_expected.not_to be_first_step }
    end
  end

  describe '#last_step?' do
    context 'when the current step is the last step' do
      before do
        subject.instance_variable_set(:@current_step, 'final')
      end

      it { is_expected.to be_last_step }
    end

    context 'when the current step is not the last step' do
      before do
        subject.instance_variable_set(:@current_step, 'scams')
      end

      it { is_expected.not_to be_last_step }
    end
  end

  describe '#next_step' do
    context 'when the current step is not set' do
      it 'returns the next step' do
        expect(subject.next_step).to eq('scams')
      end
    end

    context 'when the current step is set' do
      before do
        subject.instance_variable_set(:@current_step, 'scams')
      end

      it 'returns the next step' do
        expect(subject.next_step).to eq('final')
      end
    end

    context 'when the current step is the last step' do
      before do
        subject.instance_variable_set(:@current_step, 'final')
      end

      it 'returns nil' do
        expect(subject.next_step).to be_nil
      end
    end
  end
end
