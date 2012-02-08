require 'spec_helper'

describe Jackpot::Customer do
  it { should     belong_to                :subscription             } 
  it { should_not allow_mass_assignment_of :credit_card_number       } 
  it { should_not allow_mass_assignment_of :credit_card_expiry_year  } 
  it { should_not allow_mass_assignment_of :credit_card_expiry_month } 
  it { should_not allow_mass_assignment_of :credit_card_token        } 

  let(:customer)      { Jackpot::Customer.new } 
  let(:card)          { Jackpot::Card.new credit_card_hash } 
  let(:invalid_card)  { Jackpot::Card.new credit_card_hash('9', :year => '2000') } 

  describe ".expiration_date" , :vcr do
    it "should return this card expiration date" do
      customer.update_credit_card(card)
      customer.expiration_date.should == "1/#{next_year}"
    end 
  end 


  describe ".update_credit_card_number" do

    context "when card is invalid" do
      it "raises invalid card exception" do
        expect { customer.update_credit_card(invalid_card)}.to raise_error(Jackpot::Errors::CardIsInvalid)
      end 

      it "shouldn't be persisted" do
        expect { customer.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end 

    end 

    context "when card is valid", :vcr  do
      before(:each) do 
        customer.update_credit_card(card)
      end 

      it "should masquerade the card number" do
        customer.credit_card_number.should                == 'XXXX-XXXX-XXXX-4242'
      end 

      it { customer.credit_card_expiry_month.should       == 1          } 
      it { customer.credit_card_expiry_year.should        == next_year  } 

      context "when persisting" do

        let(:retrieved_customer) { Jackpot::Customer.find customer } 

        it "should store this card at the gateway" do
          # Check corresponding VCR for this magical number 
          retrieved_customer.credit_card_token.should == '977656792'
        end 

        it "should persist the card information" do 
          retrieved_customer.credit_card_number.should == 'XXXX-XXXX-XXXX-4242'
        end 

        it "should persist in the database the ONLY last four digits" do
          retrieved_customer.credit_card_number.should == 'XXXX-XXXX-XXXX-4242'
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

end 
