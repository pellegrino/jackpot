require 'spec_helper'

describe Jackpot::PaymentsController do

  describe "POST 'create'" do
    before(:each) do
      Jackpot::Payment.stub!(:create).with("foo" => "bar")
    end 
    it "creates a new payment" do 
      Jackpot::Payment.should_receive(:create).with("foo"=>"bar")
      post :create, payment: { foo: "bar" } , :use_route => :jackpot
    end 

    it "redirects to payments list page" do
      post :create, payment: { foo: "bar" } , :use_route => :jackpot
      response.should redirect_to(payments_path)
    end

    it "assigns a success message" do
      post :create, payment: { foo: "bar" } , :use_route => :jackpot
      flash[:notice].should be_present
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
