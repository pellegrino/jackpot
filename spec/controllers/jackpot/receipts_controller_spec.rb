require 'spec_helper'


describe Jackpot::ReceiptsController do

  let(:user) { FactoryGirl.create :user } 

  before :each do 
    sign_in :user , user 
  end 


  # GET /payments/42/receipt.pdf
  
  describe ".show" do

    before do
      # to avoid having it converting to pdf every time this test runs
      WickedPdf.any_instance.stub(:pdf_from_string)
                                  .and_return("pdf converted document")

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


