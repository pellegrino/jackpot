require 'spec_helper'


feature "Assign Subscription to customer", %q{
  To bill my plan's subscribers  
  As a user
  I want to record their plan and subscription  
} do
  
  let(:user)         {  FactoryGirl.create(:user) }

  before do
    sign_in user

    @subscription = FactoryGirl.create(:subscription, :name => "Gold")
  end

  scenario "creating a customer and assigning a new subscription" do
    visit customers_path
    click_link "New Customer"

    fill_in "customer[email]", with: "john@doe.net"
    select  'Gold', :from => 'Subscription'

    click_button "Create Customer"

    # Customer created successfully 
    page.should have_css(".alert.alert-success") 
    # Subscription is listed at Customer details 
    page.should have_content("Gold")
    
    visit subscription_path(@subscription)
    within("#subscribers") do
      page.should have_content("john@doe.net")
    end 

  end 
 
end 
