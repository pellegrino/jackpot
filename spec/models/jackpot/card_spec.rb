require 'spec_helper'

describe Jackpot::Card do

  describe "#create" do

    it "creates an active merchant card with the given parameters" do
      Jackpot::Card.create(credit_card_hash).should be_a(ActiveMerchant::Billing::CreditCard)
    end

  end 

end 
