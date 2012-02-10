require 'spec_helper'

describe Jackpot::Subscription do
  it { should have_many(:customers)       } 
  it { should validate_presence_of :name  }
  it { should have_many(:payments)        }


  describe ".charge" do
    let(:customer_to_be_charged) { Factory(:customer_with_subscription)  } 
    subject { customer_to_be_charged.subscription  } 

    it "creates a payment for the given customer" , 
      :vcr => { :cassette_name => "jackpot/subscription_charge" } do
      expect { subject.charge(customer_to_be_charged)}.to change(subject.payments, :count).by(1)
    end 
  end   

end
