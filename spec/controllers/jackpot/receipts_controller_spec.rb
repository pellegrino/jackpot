require 'spec_helper'


describe Jackpot::ReceiptsController do

  let(:user) { FactoryGirl.create :user } 

  before :each do 
    sign_in :user , user 
  end 


  # GET /payments/42/receipt
  
  describe ".show" do
    it "assigns requested payment to :payment" do
      Jackpot::Payment.stub!(:find).with('42').and_return('payment')
      get :show , :payment_id => '42', :use_route => 'jackpot'

      assigns[:payment].should == 'payment'
    end 

  end 

end 


