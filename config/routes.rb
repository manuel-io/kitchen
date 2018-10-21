Rails.application.routes.draw do
  root 'sources#list'
    get '/feed', to: redirect('/sources/feed.atom', status: 302)

  resources :vegetables, except: [:show]
  resources :products

  resources :recipes do
    get 'picture', on: :member
    get 'embedded', on: :member
  end

  resources :recipe_parts, except: [:show]

  resources :sources, except: [:show] do
    get 'list', on: :collection
    get 'feed', on: :collection
  end

  resources :connections, only: [:show, :edit, :update]

  resources :components, only: [:show]  do
    resources :ingredients, except: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy] do
    get :index, path: '/'
    get :logout
  end

  namespace :user do
    resources :users, only: [:show] do
    end
    root 'overview#index'
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
