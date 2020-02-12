# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :trips, only: %i[create show]
      resources :activity_types, only: %i[create index]
      resources :hotels, only: %i[create index]
      delete 'hotels', to: 'hotels#destroy'
    end
  end
end
