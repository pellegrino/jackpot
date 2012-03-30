module Jackpot

  class ReceiptsController < ApplicationController
    before_filter :authenticate_user!

    def show
      @payment = Payment.find params[:payment_id]

      respond_to do |format|
        format.html
        format.pdf { render :pdf => 'receipt' }  
      end 
    end 

  end 

end 
