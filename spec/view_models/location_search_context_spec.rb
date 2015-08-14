RSpec.describe LocationSearchContext do
  subject(:location_search_context) do
    described_class.new(position: position, distance: distance)
  end

  let(:distance) { 10.1 }
  let(:position) { 3 }

  it { is_expected.to respond_to(:distance) }
  it { is_expected.to respond_to(:position) }
end
