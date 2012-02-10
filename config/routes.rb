Jackpot::Engine.routes.draw do
  resources :customers  do
    member do
      put "credit_card" 
    end 
  end 

  resources :subscriptions 
  resources :payments 


  root :to => "payments#index"
  devise_for :users, {
    :class_name => 'Jackpot::User',
    :module     => :devise
  }
end
