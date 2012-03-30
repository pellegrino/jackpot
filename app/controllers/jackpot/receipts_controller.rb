module Jackpot

  class ReceiptsController < ApplicationController
    before_filter :authenticate_user!

    def show
      @payment = Payment.find params[:payment_id]
      render :pdf => 'receipt', :wkhtmltopdf  => "#{Jackpot::Engine.root}/bin/wkhtmltopdf" 
    end 

  end 

end 
