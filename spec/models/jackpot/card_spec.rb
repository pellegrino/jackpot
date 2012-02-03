require 'spec_helper'

describe Jackpot::Card do

  subject { Jackpot::Card.new(credit_card_hash) }  

  describe "#new" do
    it { subject.masquerade_number.should   == 'XXXX-XXXX-XXXX-4242' } 
    it { subject.number.should              == '4242424242424242'    } 
    it { subject.month.should               == 1                     } 
    it { subject.year.should                == next_year             } 
    it { subject.first_name.should          == "John"                } 
    it { subject.last_name.should           == "Doe"                 } 
    it { subject.verification_value.should  == 123                   } 
  end 


end 
