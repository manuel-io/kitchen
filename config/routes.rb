Rails.application.routes.draw do

  resources :products
  resources :sources do
    get 'list', on: :collection
  end

  resource :session, only: [:new, :create, :destroy] do
    get :index, path: '/'
    get :logout
  end

  namespace :admin do
    resources :users, only: [:new, :create, :edit, :update, :destroy] do
      patch :email, on: :member
      patch :password, on: :member
    end
    root 'overview#index'
  end

  resources :recipes do
    get 'show_picture', on: :collection
  end
  resources :components do
    resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
  end

  root 'sources#list'
  # root 'sources#list', defaults: { format: 'markdown' }
end
