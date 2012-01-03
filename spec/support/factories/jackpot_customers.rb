# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer , class: Jackpot::Customer do
    email 
    description "MyText"

    factory :customer_with_subscription do
      subscription
    end
  end

  sequence :email do |n|
    "john#{n}@doe.com"
  end

end
