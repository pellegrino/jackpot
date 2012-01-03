require 'spec_helper'

describe Jackpot::CustomersHelper do
  describe "#subscription_name_when_available" do
    it "returns '-' when there is no subscription available" do
      customer = FactoryGirl.build(:customer)
      helper.subscription_name_when_available(customer).should == "-"
    end 

    it "returns the subscription name when it is available" do
      customer = FactoryGirl.build(:customer_with_subscription)
      helper.subscription_name_when_available(customer).should == "Gold"
    end 

  end 
end
