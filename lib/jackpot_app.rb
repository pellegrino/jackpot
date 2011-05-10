require 'sinatra'
require 'jackpot'

post '/subscriptions' do
  Subscription.create(params[:subscription])
end


