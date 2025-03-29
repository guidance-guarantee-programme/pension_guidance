RSpec.describe StripSessionCookie, '#call' do
  let(:app) { double }
  let(:response) { [200, { 'Set-Cookie' => 'obai' }, 'body'] }

  subject { described_class.new(app, paths: %w[/en/tax]) }

  context 'with a matching path' do
    it 'strips cookies from the request and response' do
      env = { 'HTTP_COOKIE' => 'ohai', 'PATH_INFO' => '/en/tax' }

      expect(app).to receive(:call).with({ 'PATH_INFO' => '/en/tax' }).and_return(response)

      subject.call(env).tap do |_, headers, _|
        expect(headers).to be_empty
      end
    end
  end

  context 'with no matching path' do
    it 'does not strip cookies from the request and response' do
      env = { 'HTTP_COOKIE' => 'ohai', 'PATH_INFO' => '/en/nope' }

      expect(app).to receive(:call).with(env).and_return(response)

      subject.call(env).tap do |_, headers, _|
        expect(headers).to include('Set-Cookie')
      end
    end
  end
end
