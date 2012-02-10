module Jackpot
  class PaymentsController < ApplicationController
    before_filter :authenticate_user!

    def create
      @customer = Jackpot::Customer.find params[:customer_id] 

      respond_to do |format|
        if @customer.pay_subscription
          format.html { redirect_to(payments_url, notice: "Payment recorded successfully")} 
        end
      end 
    end

    def index
      @payments = Payment.all
    end 
 
  end
end
