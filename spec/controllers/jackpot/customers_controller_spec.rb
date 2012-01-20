require 'spec_helper'

module Jackpot 
  describe CustomersController do

    def valid_attributes
      {}
    end

    let(:customer) {  Customer.create! valid_attributes } 

    describe "PUT edit_credit_card" do

      it "fetches requested customer" do
        Customer.any_instance.should_receive(:update_credit_card_number).with({"number" => '1' })
        put :credit_card, :id => customer.id , :credit_card => { :number => '1' } , :use_route => "jackpot"
      end 

      it "sets a success message" do
        customer.stub!(:update_credit_card_number).with({"number" => '1'}).and_return(true)
        put :credit_card, :id => customer.id , :credit_card => { :number => '1' } , :use_route => "jackpot"
        should set_the_flash
      end 



    end 

    describe "GET index" do
      it "assigns all customers as @customers" do
        customer = Customer.create! valid_attributes
        get :index, :use_route => "jackpot"
        assigns(:customers).should eq([customer])
      end
    end

    describe "GET show" do
      it "assigns the requested customer as @customer" do
        customer = Customer.create! valid_attributes
        get :show, :id => customer.id , :use_route => "jackpot"
        assigns(:customer).should eq(customer)
      end
    end

    describe "GET new" do
      it "assigns a new customer as @customer" do
        get :new, :use_route => "jackpot"
        assigns(:customer).should be_a_new(Customer)
      end
    end

    describe "GET edit" do
      it "assigns the requested customer as @customer" do
        customer = Customer.create! valid_attributes
        get :edit, :id => customer.id, :use_route => "jackpot"
        assigns(:customer).should eq(customer)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Customer" do
          expect {
            post :create, :customer => valid_attributes, :use_route => "jackpot"
          }.to change(Customer, :count).by(1)
        end

        it "assigns a newly created customer as @customer" do
          post :create, :customer => valid_attributes, :use_route => "jackpot"
          assigns(:customer).should be_a(Customer)
          assigns(:customer).should be_persisted
        end

        it "redirects to the created customer" do
          post :create, :customer => valid_attributes, :use_route => "jackpot"
          response.should redirect_to(Customer.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved customer as @customer" do
          # Trigger the behavior that occurs when invalid params are submitted
          Customer.any_instance.stub(:save).and_return(false)
          post :create, :customer => {}, :use_route => "jackpot"
          assigns(:customer).should be_a_new(Customer)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Customer.any_instance.stub(:save).and_return(false)
          post :create, :customer => {}, :use_route => "jackpot"
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested customer" do
          customer = Customer.create! valid_attributes
          # Assuming there are no other customers in the database, this
          # specifies that the Customer created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Customer.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => customer.id, :customer => {'these' => 'params'}, :use_route => "jackpot"
        end

        it "assigns the requested customer as @customer" do
          customer = Customer.create! valid_attributes
          put :update, :id => customer.id, :customer => valid_attributes, :use_route => "jackpot"
          assigns(:customer).should eq(customer)
        end

        it "redirects to the customer" do
          customer = Customer.create! valid_attributes
          put :update, :id => customer.id, :customer => valid_attributes, :use_route => "jackpot"
          response.should redirect_to(customer)
        end
      end

      describe "with invalid params" do
        it "assigns the customer as @customer" do
          customer = Customer.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Customer.any_instance.stub(:save).and_return(false)
          put :update, :id => customer.id, :customer => {}, :use_route => "jackpot"
          assigns(:customer).should eq(customer)
        end

        it "re-renders the 'edit' template" do
          customer = Customer.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Customer.any_instance.stub(:save).and_return(false)
          put :update, :id => customer.id, :customer => {}, :use_route => "jackpot"
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested customer" do
        customer = Customer.create! valid_attributes
        expect {
          delete :destroy, :id => customer.id, :use_route => "jackpot"
        }.to change(Customer, :count).by(-1)
      end

      it "redirects to the customers list" do
        customer = Customer.create! valid_attributes
        delete :destroy, :id => customer.id, :use_route => "jackpot"
        response.should redirect_to(customers_path)
      end
    end

  end
end 
