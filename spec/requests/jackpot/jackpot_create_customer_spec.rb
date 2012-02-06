require 'spec_helper'


feature "Create Customers", %q{ 
  To bill monthly my customers 
  As a user
  I want to record their billing information
} do


  scenario "customer creation" do
    visit customers_path 
    click_link "New Customer"

    page.should have_no_css("#credit-card-information")

    within('form') do
      fill_in "customer[email]"       , :with => "foo@bar.com" 
      fill_in "customer[description]" , :with => "random description" 
      
      click_button("Create Customer")
    end 

    # Customer should have been created successfully 
    page.should have_css    (".alert-message.success") 
    page.should have_content("foo@bar.com"           )
  end 

  scenario "assigning credit card information to customer" do
    @customer = FactoryGirl.create("customer", :email => "baz@bar.com")


    visit customers_path 
    within("#customer-#{@customer.id}") { click_link "Edit" } 


    page.should have_css      ("#credit-card-information" )
    # fill credit card's information
    within("#credit-card-form") do
      fill_in "credit_card[number]"              , :with => "1"
      fill_in "credit_card[month]"               , :with => "1"
      fill_in "credit_card[year]"                , :with => next_year 
      fill_in "credit_card[first_name]"          , :with => 'John' 
      fill_in "credit_card[last_name]"           , :with => 'Doe' 
      fill_in "credit_card[verification_value]"  , :with => 411 

      # submit data

      click_button 'Confirm'
    end 
    page.should have_css         (".alert-message.success" ) 

    within("#customer") do
      # Not quite what would be expected but this is due Bogus Gateway usage
      page.should have_content     ("XXXX-XXXX-XXXX-1"       )
      page.should have_content     ( next_year               )
      page.should have_content     ( "1"  )
      page.should have_no_content  ( "411")
    end 

  end 

end 
