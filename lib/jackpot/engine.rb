require 'active_merchant'
require 'devise'
require 'formtastic-bootstrap'

require 'wicked_pdf'

module Jackpot
  class Engine < Rails::Engine
    isolate_namespace Jackpot
    config.generators do |g|
      g.test_framework      :rspec, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => "spec/support/factories" 
    end
  end
end
Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder
