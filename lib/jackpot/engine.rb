require 'haml'
require 'active_merchant'

module Jackpot
  class Engine < Rails::Engine
    isolate_namespace Jackpot
    config.generators do |g|
      g.test_framework      :rspec, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories" 
      g.template_engine     :haml
    end
  end
end
