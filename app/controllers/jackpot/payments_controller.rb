module Jackpot
  class PaymentsController < ApplicationController

    def create
      Payment.create(params[:payment])
      respond_to do |format|
        format.html { redirect_to(payments_url, notice: "Payment recorded successfully")} 
      end 
    end

    def index
      @payments = Payment.all
    end 
 
  end
end
