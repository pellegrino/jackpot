require 'spec_helper'

feature "Receive Payments", %q{
  To earn money
  As a user 
  I want to be able to bill credit cards from my customers 
} do


  scenario "receiving valid credit card information" do
    # Dummy html to simulate a user entering data 
    visit "/payment.html"

    within "form" do
      fill_in "amount",                 :with => '10000' 
      fill_in "credit_card[number]",    :with => '4111111111111111' 
      fill_in "credit_card[month]",     :with => '8' 
      fill_in "credit_card[year]",      :with => '2009' 
      fill_in "credit_card[first_name]",:with => 'John' 
      fill_in "credit_card[last_name]", :with => 'Doe' 
      fill_in "credit_card[verification_code]",
                                        :with => '123' 

      click_button 'confirm' 
    end 

    page.should have_content("success") 
  end 
end 
