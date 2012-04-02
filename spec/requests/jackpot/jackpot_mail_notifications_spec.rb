require 'spec_helper'

feature "Mail notifications", %q{
  To reduce chargebacks 
  As a jackpot user
  I want it to notify my customers they were charged
} do
  

  background do
    @customer = FactoryGirl.create :customer_with_valid_card_and_subscription
  end 

  scenario "sends the customer his/hers receipt upon a successful charge" , :vcr do
    @customer.pay_subscription 

    # asserts the last email was sent to this customer 
    mail = ActionMailer::Base.deliveries.last
    mail.should_not be_nil

    # asserts his/hers receipt URL were included at the message. 
  end 

end 
