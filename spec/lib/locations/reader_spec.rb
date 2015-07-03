require 'fakeredis'

RSpec.describe Locations::Reader, '#call' do
  let(:now) { Time.zone.local(2015, 6, 30, 14) }
  let(:key) { 'locations' }
  let(:ttl) { 1 }
  let(:json) { 'json' }
  let(:path) { '/path/to/locations.json' }
  let(:redis) { Redis.new }
  let(:reader) { described_class.new(path, redis, ttl) }

  def json_in_redis
    redis.get(key)
  end

  def keys_in_redis
    redis.keys('*')
  end

  def expiry_in_seconds
    redis.ttl(key)
  end

  subject(:read) { reader.call }

  before do
    Timecop.freeze(now)
    redis.flushdb
    allow(reader).to receive(:read_json).with(path).and_return(json)
  end

  after do
    Timecop.return
  end

  context 'with a path on the filesystem' do
    before { read }

    it { is_expected.to eq(json) }

    specify { expect(keys_in_redis).to be_empty }
  end

  context 'with a url' do
    let(:path) { 'http://locator/locations.json' }

    context 'and the data does not exist in Redis' do
      before { read }

      it { is_expected.to eq(json) }

      specify { expect(json_in_redis).to eq(json) }

      context 'when a TTL is set' do
        let(:ttl) { 1 }

        specify { expect(expiry_in_seconds).to eq(ttl) }
      end

      context 'when a TTL is not set' do
        let(:ttl) { nil }

        specify { expect(expiry_in_seconds).to eq(60) }
      end
    end

    context 'and the data exists in Redis' do
      let(:existing_json) { 'existing json' }

      before do
        redis.set(key, existing_json)
        read
      end

      it { is_expected.to eq(existing_json) }

      specify { expect(json_in_redis).to eq(existing_json) }
    end
  end
end
