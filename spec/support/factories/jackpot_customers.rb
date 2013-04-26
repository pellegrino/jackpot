# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer , class: Jackpot::Customer do
    email
    description "MyText"

    factory :customer_with_subscription do
      subscription
    end

    factory :customer_with_valid_card do
      after(:create) do |customer|
        customer.update_credit_card credit_card
      end
    end

    factory :customer_with_subscription_and_valid_card , :parent => :customer_with_valid_card do
      subscription
    end

    # Because i always guess the opposite order
    factory :customer_with_valid_card_and_subscription , :parent => :customer_with_subscription_and_valid_card
  end

  sequence :email do |n|
    "john#{n}@doe.com"
  end
end
