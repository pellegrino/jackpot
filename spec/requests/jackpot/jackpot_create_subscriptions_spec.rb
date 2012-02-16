require 'spec_helper'


feature "Create subscriptions", %q{
  To provide subscriptions options to my customers
  As a user 
  I want to be able to record their pricing and name
} do

  let(:user) { Factory(:user) } 
  background do
    sign_in user
  end 

  scenario "creating a new subscription" do 
    visit subscriptions_path
    click_link "New Subscription"

    fill_in "subscription[name]" ,       with: "Gold"
    fill_in "subscription[price]",       with: "3000"
    fill_in "subscription[description]", with: "Great subscription"

    click_button('Create Subscription')
    page.should have_css(".alert.alert-success") 

    within("#subscription-details") do
      page.should have_content("Gold")
      page.should have_content("Great subscription")
      page.should have_content("$30.00")
    end
  end 

end 
