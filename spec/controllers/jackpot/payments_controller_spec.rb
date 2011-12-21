require 'spec_helper'

  describe Jackpot::PaymentsController do

    describe "POST 'create'" do
      it "returns http success" do
        post :create, foo: "bar", :use_route => :jackpot
        response.should be_success
      end
    end
  end 
