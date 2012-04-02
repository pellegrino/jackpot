# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment , :class => Jackpot::Payment do
    amount 1000
    description "description"
    created_at Time.now
    public_token 'abc'

    subscription
    association :customer, :factory => :customer_with_valid_card_and_subscription
  end
end

