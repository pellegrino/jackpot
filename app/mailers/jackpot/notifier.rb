require 'open-uri'

module Jackpot
  class Notifier < ActionMailer::Base
    def send_receipt(payment)
      @payment = payment

      mail(:to => "#{@payment.customer.email}", 
           :from => "ohai@example.com",
           :subject => "Payment receipt")
    end 

  end
end
