Rails.application.routes.draw do
  root to: "pages#home"
  
  devise_for :users
  
  resources :meetings do
    member do
      patch :accept
      patch :reject
      patch :cancel
      patch :complete
    end
  end
  
  resources :transactions, only: [:index, :show]
  
  resources :users, only: [] do
    collection do
      get 'search'
    end
  end
  
  # API routes
  namespace :api do
    namespace :v1 do
      resources :meetings, only: [:index, :show, :create]
      resources :users, only: [:show] do
        collection do
          post :verify_siret
        end
      end
      get 'companies/search', to: 'companies#search'
    end
  end

  # Admin routes
  ActiveAdmin.routes(self)
end
