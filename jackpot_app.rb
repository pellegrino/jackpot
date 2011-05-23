ENV['RACK_ENV'] ||= 'development'
require_relative 'lib/jackpot_server'

require 'sinatra'
require 'json'

get "/customers" do
  content_type :json
  customers = Customer.all

  customers.to_json
end

post "/customers" do
  Customer.create(params[:customer])
end

delete '/subscriptions' do
  subscription = Subscription.get(params[:id])
  subscription.destroy
end

post '/subscriptions' do
  Subscription.create(params[:subscription])
end

put '/subscriptions' do
  Subscription.get(params[:id]).update(params[:subscription])
end

get '/subscriptions' do
  content_type :json

  subscriptions = Subscription.all
  subscriptions.to_json
end

get '/subscriptions/:id' do
  content_type :json

  Subscription.get(params[:id]).to_json
end
