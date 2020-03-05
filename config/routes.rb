# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: :facebook_login
  }
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :trips, only: %i[create show index]
      delete 'trips', to: 'trips#destroy'
      resources :activity_types, only: %i[create index]
      delete 'activity_types', to: 'activity_types#destroy'
      resources :hotels, only: %i[create index]
      delete 'hotels', to: 'hotels#destroy'
      resources :ratings, only: %i[create show]
    end
  end
end
