require 'spec_helper'

describe Jackpot::PaymentsController do

  describe "POST 'create'" do
    before(:each) do
      Jackpot::Customer.stub!(:find).with('42').and_return  customer
      Jackpot::Customer.stub!(:find).with('1').and_return   invalid_customer
    end 

    let(:customer)         { stub(:pay_subscription => true) } 
    let(:invalid_customer) { stub(:pay_subscription => false) } 

    context "when customer pay his/hers subscription successfuly" do 
      it "fetches the customer we're charging" do
        post :create, :customer_id => '42', :use_route => :jackpot
        response.should redirect_to(payments_path)
      end 
      it "assigns a success message" do
        post :create, :customer_id => '42' , :use_route => :jackpot
        flash[:notice].should be_present
      end
    end 

    context "when customer could not pay his/hers subscription" do 
      it "does not assign a success message" do
        post :create, :customer_id => '42' , :use_route => :jackpot
        flash[:notice].should be_present
      end
    end 
  end


  describe "GET 'index'" do
    it "returns all the payments already received" do
      Jackpot::Payment.stub!(:all).and_return(['payments'])
      get :index, :use_route => :jackpot
      assigns[:payments].should be_eql ['payments']
    end 
  end   
end 
