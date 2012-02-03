require 'spec_helper'

describe Jackpot::Card do

  subject { Jackpot::Card.new(credit_card_hash) }  

  describe "#new" do
    it { subject.masquerade_number.should   == 'XXXX-XXXX-XXXX-4242' } 
    it { subject.number.should              == '4242424242424242'    } 
    it { subject.month.should               == 1                     } 
    it { subject.year.should                == next_year             } 
    it { subject.verification_value.should  == 123                   } 
  end 


  describe ".store" do
    it "store this card at the gateway" do
      Jackpot::Payment.gateway.should_receive(:store_card).with(subject)
      subject.store
    end 
  end 

end 
