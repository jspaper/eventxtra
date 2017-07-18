Rails.application.routes.draw do
  resources :events do
    resources :attendee_imports
    resources :attendees
  end
  
  devise_for :users
  
  root :to => "pages#home"
end
