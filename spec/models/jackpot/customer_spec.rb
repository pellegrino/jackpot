require 'spec_helper'

describe Jackpot::Customer do
  it { should     belong_to(:subscription)                     } 
  it { should_not allow_mass_assignment_of :credit_card_number } 

  let(:card_hash) do 
    { :number     => '5105105105105100',
      :month      => '12',
      :year       => '2012',
      :first_name => 'John',
      :last_name  => 'Doe',
      :verification_value  => '123 ' }
  end 
  let(:customer) { Jackpot::Customer.new } 

  describe ".update_credit_card_number=" do

    before(:each) do 
      customer.update_credit_card_number card_hash
    end 

    it "should masquerade the card number" do
      customer.credit_card_number.should == 'XXXX-XXXX-XXXX-5100'
    end 

    context "when persisting" do
      before(:each) do
        customer.save!
      end 
      let(:retrieved_customer) { Jackpot::Customer.last } 

      it "should persist in the database the ONLY last four digits" do
        retrieved_customer.credit_card_number.should      == 'XXXX-XXXX-XXXX-5100'
      end 
      it "should NEVER persist in the database the actual card number" do
        retrieved_customer.credit_card_number.should_not  == '5105105105105100' 
      end 
    end 
  end
end 
