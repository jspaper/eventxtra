require 'sidekiq/web'

Rails.application.routes.draw do
  resources :events do
    resources :attendee_imports
    resources :attendees
  end
  
  devise_for :users
  
  mount Sidekiq::Web => '/sidekiq'
  
  root :to => "pages#home"
end
