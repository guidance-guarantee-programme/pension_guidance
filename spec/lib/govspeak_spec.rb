RSpec.describe ActionView::Template::Handlers::Govspeak do
  subject(:handler) { ActionView::Template::Handlers::Govspeak.new }

  describe '#call' do
    let(:template) { instance_double('ActionView::Template', source: govspeak) }
    let(:govspeak) { File.read Pathname.new(__FILE__).dirname.parent.join('fixtures', 'govspeak.md') }
    let(:result)   { File.read Pathname.new(__FILE__).dirname.parent.join('fixtures', 'govspeak.html') }

    it 'converts Govspeak to HTML' do
      expect(handler.call(template)).to eq result
    end
  end
end
