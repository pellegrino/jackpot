require 'spec_helper'

feature "Receive Payments", %q{
  To earn money
  As a user 
  I want to be able to bill credit cards from my customers 
} do

  background do
     @customer = Factory(:customer_with_subscription_and_valid_card, 
                         :email => "john@doe.com")
  end 

  # TODO: Rewrite this test making it access the API instead
  scenario "receiving payment" , :vcr => { :cassette_name => "jackpot/receiving_payments" } do
    # Dummy html form to simulate a user entering data 
    visit "/payment.html"

    within "form" do 
      fill_in "customer_id",        :with => "#{@customer.id}"
      click_button 'confirm' 
    end 

    page.should have_content("success") 
    within('#latest-payments') do 
      page.should have_content('john@doe.com')
      page.should have_content('$3,000.00')
      page.should have_content('less than a minute') 
    end
  end 
end 
