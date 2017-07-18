Rails.application.routes.draw do
  resources :events do
    resources :attendee_imports
  end
  
  devise_for :users
end
