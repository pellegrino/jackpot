require 'spec_helper'


describe Jackpot::ReceiptsController do
  before do
    # to avoid having it converting to pdf every time this test runs
    WickedPdf.any_instance.stub(:pdf_from_string)
                                .and_return("pdf converted document")
  end 

  
  # GET /payments/42/receipt.pdf/abc
  describe ".public_show" do
    let(:payment_mock) { mock_model(Jackpot::Payment) } 

    before do
      Jackpot::Payment.stub!(:public_fetch).with('42',:public_token =>'foo').and_return(payment_mock)
    end 

    it "fetches the requested receipt using both public_token and id" do
      get :public_show, :payment_id => '42', :public_token => 'foo', :use_route => 'jackpot', :format => 'pdf'
      assigns[:payment].should == payment_mock
    end 

    it "renders as a pdf" do
      get :public_show, :payment_id => '42', :public_token => 'foo', :use_route => 'jackpot', :format => 'pdf'
      response.content_type.should == 'application/pdf'
    end 

  end 


  # GET /payments/42/receipt.pdf
  describe ".show" do
    let(:user) { FactoryGirl.create :user } 

    before do
      sign_in :user , user 
      Jackpot::Payment.stub!(:find).with('42').and_return('payment')
    end 

    it "assigns requested payment to :payment" do
      get :show , :payment_id => '42', :use_route => 'jackpot', :format => :pdf
      assigns[:payment].should == 'payment'
    end 

    it "renders as a pdf" do
      get :show , :payment_id => '42', :use_route => 'jackpot', :format => :pdf
      response.content_type.should == 'application/pdf'
    end 

  end 

end 


