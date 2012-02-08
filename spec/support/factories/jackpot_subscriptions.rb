# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription , class: Jackpot::Subscription do
    name "Gold"
    price 3000 
    billing_period 30 # in days 
  end
end
