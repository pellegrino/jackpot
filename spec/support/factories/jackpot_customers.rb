# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer , class: Jackpot::Customer do
    email 
    description "MyText"

    factory :customer_with_subscription do
      subscription
    end

    factory :customer_with_valid_card do
      after_create do |customer|
        customer.update_credit_card valid_card 
      end 
    end 

    factory :customer_with_subscription_and_valid_card , :parent => :customer_with_valid_card do
      subscription
    end 
  end

  sequence :email do |n|
    "john#{n}@doe.com"
  end

end


def valid_card
  @card ||= Jackpot::Card.new(:first_name => 'foo', :last_name => 'bar', 
                    :number => '5555555555554444',
                    :month => 1,
                    :year => next_year,
                    :verification_value => 123)
end 
