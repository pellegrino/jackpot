require 'activemerchant'
require 'sinatra'
require 'json'

require_relative 'models'
require_relative 'payment'
require_relative 'app'


module Jackpot
  class Application < Sinatra::Base
    get "/customers" do
      content_type :json
      customers = Jackpot::Models::Customer.all

      customers.to_json
    end

    post "/customers" do
      Jackpot::Models::Customer.create(params[:customer])
    end

    delete '/subscriptions' do
      subscription = Jackpot::Models::Subscription.get(params[:id])
      subscription.destroy
    end

    post '/subscriptions' do
      Jackpot::Models::Subscription.create(params[:subscription])
    end

    put '/subscriptions' do
      Jackpot::Models::Subscription.get(params[:id]).update(params[:subscription])
    end

    get '/subscriptions' do
      content_type :json

      subscriptions = Jackpot::Models::Subscription.all
      subscriptions.to_json
    end

    get '/subscriptions/:id' do
      content_type :json

      Jackpot::Models::Subscription.get(params[:id]).to_json
    end
  end

end
