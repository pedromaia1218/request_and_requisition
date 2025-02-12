Rails.application.routes.draw do
  root 'home#index'

  resources :resources

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
