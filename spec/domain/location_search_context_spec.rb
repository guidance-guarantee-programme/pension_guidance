RSpec.describe LocationSearchContext, '.build' do
  let(:id) { 22 }
  let(:distance) { 10.102 }
  let(:location) { double(id: id) }
  let(:search_results) do
    [
      double(id: 11, distance: 5.0),
      double(id: id, distance: distance),
      double(id: 33, distance: 15.0)
    ]
  end

  subject(:context) { described_class.build(search_results, location) }

  context 'with no search results' do
    let(:search_results) { [] }

    it { is_expected.to be_nil }
  end

  context 'with search results' do
    specify { expect(context.distance).to eq('10.10') }
    specify { expect(context.position).to eq(2) }
  end
end
