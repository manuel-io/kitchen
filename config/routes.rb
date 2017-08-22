Rails.application.routes.draw do

  get 'new_session' => 'sources#list'
  get 'products' => 'sources#list'
  get 'recipes' => 'sources#list'
  get 'components' => 'sources#list'
  get 'sources' => 'sources#list'

  root 'sources#list'
end
