RSpec.describe FrontMatterParser do
  subject(:parser) do
    FrontMatterParser.new <<-EXAMPLE
---
title: The Jabberwocky
description: A "nonsense" poem
---
Twas brillig, and the slithy toves
Did gyre and gimble in the wabe:
All mimsy were the borogoves,
And the mome raths outgrabe.
    EXAMPLE
  end

  describe '#front_matter' do
    it 'returns key/value pairs extraced from the front matter in the source' do
      expect(parser.front_matter).to eq('title' => 'The Jabberwocky', 'description' => 'A "nonsense" poem')
    end
  end

  describe '#content' do
    it 'returns the source with the front matter stripped' do
      stripped_source = "Twas brillig, and the slithy toves
Did gyre and gimble in the wabe:
All mimsy were the borogoves,
And the mome raths outgrabe.
"
      expect(parser.content).to eq(stripped_source)
    end
  end

  context 'given a source without a front matter' do
    let(:source) { 'Text with no front matter' }
    subject(:parser) { FrontMatterParser.new(source) }

    describe '#content' do
      it 'returns the original source' do
        expect(parser.content).to eq(source)
      end
    end

    describe '#front_matter' do
      it 'returns an empty hash' do
        expect(parser.front_matter).to eq({})
      end
    end
  end
end
