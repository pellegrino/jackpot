require 'spec_helper'

feature "Receive Payments", %q{
  To earn money
  As a user 
  I want to be able to bill credit cards from my customers 
} do


  scenario "receiving valid credit card information" , :vcr do
    # Dummy html form to simulate a user entering data 
    visit "/payment.html"

    within "form" do fill_in "payment[amount]",                 :with => '10000' 
      fill_in "payment[credit_card][number]",    :with => '4111111111111111' 
      fill_in "payment[credit_card][month]",     :with => '8' 
      fill_in "payment[credit_card][year]",      :with => next_year
      fill_in "payment[credit_card][first_name]",:with => 'John' 
      fill_in "payment[credit_card][last_name]", :with => 'Doe' 
      fill_in "payment[credit_card][verification_value]",
                                        :with => '123' 

      click_button 'confirm' 
    end 

    page.should have_content("success") 
    within('#latest-payments') do 
      page.should have_content('John Doe')
      page.should have_content('$10,000.00')
      page.should have_content('less than a minute') 
    end
  end 
end 
