require_relative 'lib/jackpot'
require 'sinatra'
require 'json'


delete '/subscriptions' do
  subscription = Subscription.get(params[:id])
  subscription.destroy
end

post '/subscriptions' do
  Subscription.create(params[:subscription])
end

get '/subscriptions' do
  content_type :json

  subscriptions = Subscription.all
  subscriptions.to_json
end


