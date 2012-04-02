require 'open-uri'

module Jackpot
  class Notifier < ActionMailer::Base
    def send_receipt(payment)
      @payment = payment
      @payment_url = public_receipt_payment_url(:payment_id => @payment.id,
                                                :public_token => @payment.public_token)

      mail(:to => "#{@payment.customer.email}", 
           :from => "dont-reply@example.com",
           :subject => "Payment receipt")
    end 

  end
end
