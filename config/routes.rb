Rails.application.routes.draw do
  root 'sources#list'

  resources :vegetables, except: [:show]
  resources :products

  resources :recipes do
    get 'show_picture', on: :collection
  end

  resources :recipe_parts, except: [:show]

  resources :sources, except: [:show] do
    get 'list', on: :collection
  end

  resources :connections, only: [:show, :edit, :update]

  resources :components, only: [:show]  do
    resources :ingredients, except: [:index, :show]
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
end
