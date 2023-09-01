# frozen_string_literal: true

Rails.application.routes.draw do
  get 'onboarding', to: 'onboarding#new'
  post 'onboarding', to: 'onboarding#create'
  devise_for :users
end
