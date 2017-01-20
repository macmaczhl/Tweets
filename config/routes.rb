# frozen_string_literal: true
Rails.application.routes.draw do
  # resources :tweets
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  scope '/users/:id' do
    get 'tweets', to: 'tweets#index'
    post 'tweets', to: 'tweets#create'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
