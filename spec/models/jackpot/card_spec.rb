require 'spec_helper'

describe Jackpot::Card do

  describe "#new" do
    subject { Jackpot::Card.new(credit_card_hash) }  

    it { subject.masquerade_number.should   == 'XXXX-XXXX-XXXX-4242' } 
    it { subject.number.should              == '4242424242424242'    } 
    it { subject.month.should               == 1                     } 
    it { subject.year.should                == next_year             } 
    it { subject.first_name.should          == "John"                } 
    it { subject.last_name.should           == "Doe"                 } 
    it { subject.verification_value.should  == 123                   } 
  end 


  describe ".valid?" do
    it { Jackpot::Card.new(credit_card_hash('987', :year => '2000')).should_not be_valid }
    it { Jackpot::Card.new(credit_card_hash).should be_valid }
  end 

end 
