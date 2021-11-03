require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV['GOOGLE_API_KEY'] }
  c.filter_sensitive_data('<GOOGLE_API_CX>') { ENV['GOOGLE_API_CX'] }

  c.ignore_hosts 'chromedriver.storage.googleapis.com'
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
