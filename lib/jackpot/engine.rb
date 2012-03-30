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


    initializer "jackpot.wicked_pdf" do |app|
      # To use local wicket pdf provided with jackpot 
      WickedPdf.config = {
        :exe_path  => wkhtmltopdf_bin_acording_to_the_platform
      }
    end


    private 
    def wkhtmltopdf_bin_acording_to_the_platform
      # Detects if its a 64 or 32 bit
      if ['a'].pack('P').length > 4 
        "#{Jackpot::Engine.root}/bin/wkhtmltopdf-amd64"
      else 
        "#{Jackpot::Engine.root}/bin/wkhtmltopdf-i386"
      end 
    end 

  end
end



Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder
