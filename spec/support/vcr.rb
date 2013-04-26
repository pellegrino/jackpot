VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/fixtures/vcr"
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
