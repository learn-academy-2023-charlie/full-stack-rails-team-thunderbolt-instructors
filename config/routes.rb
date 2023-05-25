Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # request to see all instances
  get '/recipes' => 'recipe#index', as: 'recipes'

  # landing page
  root 'recipe#index'

  # request to add a new instance requires new and create
  get '/recipes/new' => 'recipe#new', as: 'new'
  post '/recipes' => 'recipe#create'

  # request to modify an existing instance requires edit and update
  get '/recipes/:id/edit' => 'recipe#edit', as: 'edit_recipe'
  patch '/recipes/:id' => 'recipe#update'

  # request to remove an existing instance
  delete '/recipes/:id' => 'recipe#destroy', as: 'destroy_recipe'

  # request to see one instance
  get '/recipes/:id' => 'recipe#show', as: 'recipe'

end
