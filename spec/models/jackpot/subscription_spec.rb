require 'spec_helper'

describe Jackpot::Subscription do
  it { should have_many(:customers)       } 
  it { should validate_presence_of :name  }
  it { should have_many(:payments)        }

  describe ".price" do
    let(:subscription) { subscription = Factory.build(:subscription, :price => 1095) } 

    it "outputs the current price in dollars" do
      subscription.price.should == 10.95
    end 

    it "displays price in cents" do
      subscription.price_in_cents.should == 1095
    end 

    it "displays nothing if the value is nil" do
      Jackpot::Subscription.new.price.should be_nil
    end 
    
  end 

  describe ".charge" do
    let(:customer_to_be_charged) { Factory(:customer_with_subscription)  } 
    subject { customer_to_be_charged.subscription  } 

    it "creates a payment for the given customer" , 
      :vcr => { :cassette_name => "jackpot/subscription_charge" } do
      expect { subject.charge(customer_to_be_charged)}.to change(subject.payments, :count).by(1)
    end 
  end   

end
