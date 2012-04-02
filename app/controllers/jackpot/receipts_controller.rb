module Jackpot

  class ReceiptsController < ApplicationController
    before_filter :authenticate_user!, except: [ :public_show ]

    def show
      @payment = Payment.find params[:payment_id]
      render :pdf => 'receipt' 
    end 

    ## Shows a receipt using a public access token to display a receipt without authentication
    def public_show
      @payment = Payment.public_fetch params[:payment_id], :public_token => params[:public_token]
      render :pdf => 'receipt', :template => 'jackpot/receipts/show.pdf.erb'
    end 

  end 

end 
