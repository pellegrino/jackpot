require 'spec_helper'

describe Jackpot::Customer do
  it { should     belong_to                :subscription                   } 
  it { should_not allow_mass_assignment_of :credit_card_number             } 
  it { should_not allow_mass_assignment_of :credit_card_expiry_year        } 
  it { should_not allow_mass_assignment_of :credit_card_expiry_month       } 

  let(:customer) { Jackpot::Customer.new } 


  describe ".expiration_date" do

    it "should return this card expiration date" do
      customer.update_credit_card credit_card_hash
      customer.expiration_date.should == "1/#{next_year}"
    end 

  end 


  describe ".update_credit_card_number" do

    before(:each) do 
      customer.update_credit_card credit_card_hash
    end 

    it "should masquerade the card number" do
      customer.credit_card_number.should                == 'XXXX-XXXX-XXXX-4242'
    end 

    it { customer.credit_card_expiry_month.should       == 1          } 
    it { customer.credit_card_expiry_year.should        == next_year  } 

    it "should persist the card information" do 
      reloaded_customer = customer.reload
      reloaded_customer.credit_card_number.should == 'XXXX-XXXX-XXXX-4242'
    end 

    context "when persisting" do

      let(:retrieved_customer) { customer.reload } 

      it "should persist in the database the ONLY last four digits" do
        retrieved_customer.credit_card_number.should      == 'XXXX-XXXX-XXXX-4242'
      end 

      it "should NEVER persist in the database the actual card number" do
        retrieved_customer.credit_card_number.should_not  == credit_card_hash[:number]
      end 

      it "should NEVER persist in the database the verification value" do 
        retrieved_customer.credit_card_verification_value.should_not == 123       
        retrieved_customer.credit_card_verification_value.should be_nil
      end

    end 
  end
end 
