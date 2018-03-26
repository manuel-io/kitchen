Rails.application.routes.draw do
  resources :vegetables
  resources :seasonnings
  resources :connections
  resources :recipe_parts, except: [:show]
  resources :component_parts
  resources :products
  resources :sources, except: [:show] do
    get 'list', on: :collection
  end

  resource :session, only: [:new, :create, :destroy] do
    get :index, path: '/'
    get :logout
  end

  namespace :admin do
    resources :users, only: [:new, :create, :edit, :destroy] do
      patch :update_nick, on: :member
      patch :update_email, on: :member
      patch :update_password, on: :member
    end
    root 'overview#index'
  end

  resources :recipes do
    get 'show_picture', on: :collection
  end

  resources :components, only: [:show] do
    resources :ingredients, except: [:index, :show]
  end

  root 'sources#list'
end
