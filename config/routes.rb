Rails.application.routes.draw do
  root 'home#index'

  resources :resources
  resources :categories
  resources :requests do
    member do
      get :assign_technician_form
      patch :assign_technician
      patch :attend
    end
  end

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
