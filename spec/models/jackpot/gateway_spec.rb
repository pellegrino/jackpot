require 'spec_helper'

describe Jackpot::Gateway do 

  subject { Jackpot::Gateway.new(ActiveMerchant::Billing::BogusGateway.new) } 

  describe "#store_card" do

    it "should delegate this call to ActiveMerchant's store method" do
      ActiveMerchant::Billing::BogusGateway.any_instance
                                                .should_receive(:store).with(credit_card_hash)  
      subject.store_card(credit_card_hash)
    end 

  end

end 
