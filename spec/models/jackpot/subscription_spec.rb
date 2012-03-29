require 'spec_helper'

describe Jackpot::Subscription do
  it { should have_many(:customers)       } 
  it { should validate_presence_of :name  }
  it { should have_many(:payments)        }

  describe ".price" do
    let(:subscription) { subscription = FactoryGirl.create(:subscription, :price => 1095) } 

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

    it "creates a payment for given customer" do
      subscription  = FactoryGirl.create :subscription
      customer = 'customer'

      payments = mock(['payments']) 
      payments.stub(:create).with(:customer => customer).and_return('42')
      subscription.stub!(:payments).and_return(payments)

      subscription.charge(customer).should == '42'
    end 
  end   

end
