RSpec.describe Breadcrumb do
  %i(book_an_appointment how_to_book_phone how_to_book_face_to_face).each do |factory|
    describe ".#{factory}" do
      subject(:breadcrumb) { described_class.public_send(factory) }

      specify { expect(breadcrumb).to be_a(described_class) }
      specify { expect(breadcrumb.path).to_not be_empty }
      specify { expect(breadcrumb.title).to_not be_empty }
    end
  end
end
