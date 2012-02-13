require 'spec_helper'

module Jackpot 
  describe Jackpot::SubscriptionsController do

    let(:user) { Factory(:user) }
    before do
      sign_in :user, user
    end 

    def valid_attributes
      {name: "Gold"}
    end

    describe "GET index" do
      it "assigns all subscriptions as @subscriptions" do
        subscription = Subscription.create! valid_attributes
        get :index, :use_route => "jackpot"
        assigns(:subscriptions).should eq([subscription])
      end
    end

    describe "GET show" do
      it "assigns the requested subscription as @subscription" do
        subscription = Subscription.create! valid_attributes
        get :show, :id => subscription.id, :use_route => "jackpot"

        assigns(:subscription).should eq(subscription)
      end
    end

    describe "GET new" do
      it "assigns a new subscription as @subscription" do
        get :new, :use_route => "jackpot"

        assigns(:subscription).should be_a_new(Subscription)
      end
    end

    describe "GET edit" do
      it "assigns the requested subscription as @subscription" do
        subscription = Subscription.create! valid_attributes
        get :edit, :id => subscription.id, :use_route => "jackpot"

        assigns(:subscription).should eq(subscription)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Subscription" do
          expect {
            post :create, :subscription => valid_attributes, :use_route => "jackpot"

          }.to change(Subscription, :count).by(1)
        end

        it "assigns a newly created subscription as @subscription" do
          post :create, :subscription => valid_attributes, :use_route => "jackpot"

          assigns(:subscription).should be_a(Subscription)
          assigns(:subscription).should be_persisted
        end

        it "redirects to the created subscription" do
          post :create, :subscription => valid_attributes, :use_route => "jackpot"

          response.should redirect_to(Subscription.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved subscription as @subscription" do
          # Trigger the behavior that occurs when invalid params are submitted
          Subscription.any_instance.stub(:save).and_return(false)
          post :create, :subscription => {}, :use_route => "jackpot"

          assigns(:subscription).should be_a_new(Subscription)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Subscription.any_instance.stub(:save).and_return(false)
          post :create, :subscription => {}, :use_route => "jackpot"

          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested subscription" do
          subscription = Subscription.create! valid_attributes
          Subscription.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => subscription.id, :subscription => {'these' => 'params'}, :use_route => "jackpot"
        end

        it "assigns the requested subscription as @subscription" do
          subscription = Subscription.create! valid_attributes
          put :update, :id => subscription.id, :subscription => valid_attributes, :use_route => "jackpot"

          assigns(:subscription).should eq(subscription)
        end

        it "redirects to the subscription" do
          subscription = Subscription.create! valid_attributes
          put :update, :id => subscription.id, :subscription => valid_attributes, :use_route => "jackpot"

          response.should redirect_to(subscription)
        end
      end

      describe "with invalid params" do
        it "assigns the subscription as @subscription" do
          subscription = Subscription.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Subscription.any_instance.stub(:save).and_return(false)
          put :update, :id => subscription.id, :subscription => {}, :use_route => "jackpot"

          assigns(:subscription).should eq(subscription)
        end

        it "re-renders the 'edit' template" do
          subscription = Subscription.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Subscription.any_instance.stub(:save).and_return(false)
          put :update, :id => subscription.id, :subscription => {}, :use_route => "jackpot"

          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested subscription" do
        subscription = Subscription.create! valid_attributes
        expect {
          delete :destroy, :id => subscription.id, :use_route => "jackpot"

        }.to change(Subscription, :count).by(-1)
      end

      it "redirects to the subscriptions list" do
        subscription = Subscription.create! valid_attributes
        delete :destroy, :id => subscription.id, :use_route => "jackpot"

        response.should redirect_to(subscriptions_path)
      end
    end

  end
end 
