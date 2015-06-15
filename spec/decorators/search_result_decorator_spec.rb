RSpec.describe SearchResultDecorator do
  let(:distance) { 1.0489736864844752 }
  let(:search_result) { double(distance: distance) }

  subject(:decorator) { described_class.new(search_result) }

  specify { expect(decorator.distance).to eq('1.05') }
end
