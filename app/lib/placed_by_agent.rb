class PlacedByAgent
  def initialize(remote_ip)
    @remote_ip = remote_ip
  end

  def call
    tp_ips.include?(remote_ip)
  end

  private

  def tp_ips
    ENV.fetch('TP_IP_ADDRESSES') { '' }.split(',')
  end

  attr_reader :remote_ip
end
