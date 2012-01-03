Jackpot::Engine.routes.draw do
  resources :customers

  resources :subscriptions 
  resources :payments 
end
