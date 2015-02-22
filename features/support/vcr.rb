require 'vcr'

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir     = File.expand_path('features/vcr_cassettes', Rails.root)
  config.allow_http_connections_when_no_cassette = false
  config.default_cassette_options = { :record => :new_episodes }
end

VCR.cucumber_tags do |t|
  t.tag  '@import_training'
end