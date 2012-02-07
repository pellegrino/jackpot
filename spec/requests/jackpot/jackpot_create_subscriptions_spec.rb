require 'spec_helper'


feature "Create subscriptions", %q{
  To provide subscriptions options to my customers
  As a user 
  I want to be able to record their pricing and name
} do

  scenario "creating a new subscription" do 
    visit subscriptions_path
    click_link "New Subscription"

    fill_in "subscription[name]" , with: "Gold"
    fill_in "subscription[price]", with: "30"

    click_button('Create Subscription')

    page.should have_css(".alert.alert-success") 
  end 

end 
