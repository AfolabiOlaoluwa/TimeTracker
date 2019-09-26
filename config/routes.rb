# frozen_string_literal: true

Rails.application.routes.draw do
  root 'clock_entries#index'

  get 'exceptions/show'
  get 'entry_details/index'

  resources :clock_entries do
    member do
      post :clock_out
    end
  end

  devise_for :users
end
