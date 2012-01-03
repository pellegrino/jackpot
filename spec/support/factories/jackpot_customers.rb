# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    email "MyString"
    description "MyText"
    subscription_id 1
  end
end
