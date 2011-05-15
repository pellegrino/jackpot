require File.join(File.dirname(__FILE__), 'environment')
require_relative 'lib/jackpot'



post '/subscriptions' do
  Subscription.create(params[:subscription])
end

get '/subscriptions' do
  subscriptions = Subscription.all
  subscriptions.to_json
end


