require 'sidekiq/web'

Rails.application.routes.draw do
  resources :events do
    resources :attendee_imports
    resources :attendees
  end
  
  get "/progress", :to => "pages#progress"
  
  devise_for :users
  
  mount Sidekiq::Web => '/sidekiq'
  
  root :to => "pages#home"
end
