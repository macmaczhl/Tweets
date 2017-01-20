# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: :registrations

  scope '/users/:id' do
    get 'tweets', to: 'tweets#index'
    post 'tweets', to: 'tweets#create'
  end
end
