module Jackpot

  # Uses the Jackpot configuration mailer options 
  #
  # mailer[:from] -> Default 'from' setting to be used in every email
  class Notifier < ActionMailer::Base

    # Sends the receipt to the customer who made this payment
    def send_receipt(payment)
      @payment = payment
      @payment_url = public_receipt_payment_url(:payment_id => @payment.id,
                                                :public_token => @payment.public_token)

      mail(:to => "#{@payment.customer.email}", 
           :from => Jackpot.configuration.mailer[:from],
           :subject => "Payment receipt")
    end 

  end
end
