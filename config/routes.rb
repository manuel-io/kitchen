Rails.application.routes.draw do

  resources :sources do
    get 'list', on: :collection
  end

  resource :session, only: [:new, :create, :destroy] do
    get :index, path: '/'
    get :logout
  end

  namespace :admin do
    resources :users, only: [:new, :create]
    root 'overview#index'
  end

  resources :recipes do
    get 'show_picture', on: :collection
  end
  resources :components do
    resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
  end

  root 'recipes#index'
  # root 'sources#list', defaults: { format: 'markdown' }
end
