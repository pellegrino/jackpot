require_relative '../../../lib/jackpot/configuration'
require_relative '../../../lib/jackpot/factory'

require 'active_merchant'
require 'active_support/core_ext/hash/indifferent_access'

describe Jackpot::Configuration do

  subject { Jackpot::Configuration.new } 

  before do
    Jackpot::Factory.any_instance.stub(:build).and_return('built gateway')
  end 

  it "sets the 'from' email information" do
    configuration = subject.configure do |c|
      c.default_from 'dont-reply@example.com'
      c.gateway_type 'type'
      c.gateway_login 'login'
      c.gateway_password 'password'
      c.gateway_mode :test
    end 

    subject.mailer['from'].should == 'dont-reply@example.com'
  end 


  it "sets active merchant mode using the provided information" do
    subject.configure do |c|
      c.gateway_type 'type'
      c.gateway_login 'login'
      c.gateway_password 'password'
      c.gateway_mode :test
    end 

    ActiveMerchant::Billing::Base.mode.should == :test
  end 


  it "returns built gateway" do
    subject.configure do |c|
      c.gateway_type 'type'
      c.gateway_login 'login'
      c.gateway_password 'password'
      c.gateway_mode :test
    end.should == 'built gateway'
  end 
end 

