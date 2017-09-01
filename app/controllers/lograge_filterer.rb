module LogrageFilterer
  protected

  def append_info_to_payload(payload)
    super
    payload[:params]    = request.filtered_parameters
    payload[:remote_ip] = request.remote_ip
  end
end
