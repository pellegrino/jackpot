require File.expand_path(File.dirname(__FILE__) + '/../helper')

require 'jackpot_app'
class SubscriptionsAppTest < MiniTest::Unit::TestCase

  def app
    Sinatra::Application
  end

  def setup
    Subscription.all.each { |s| s.delete }
  end

  def test_it_saves_the_subscription
    assert_difference("Subscription.all.count") do
      post '/subscriptions',  subscription: { name: "Gold" , price: 30 }
    end

    subscription = Subscription.all.first

    assert_equal "Gold",  subscription.name
    assert_equal '30', subscription.price
  end
end

