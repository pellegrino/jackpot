# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user , class: Jackpot::User do
    email 
    password              "password"
    password_confirmation "password"
  end 
end
