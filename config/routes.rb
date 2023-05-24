Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # request to see all instances
  get '/recipes' => 'recipe#index', as: 'recipes'
  # landing page
  root 'recipe#index'
  # request to add a new instance will need a form to track the user input and to save the ne instance to the database
  get '/recipes/new' => 'recipe#new', as: 'new'
  post '/recipes' => 'recipe#create'

  get '/recipes/:id/edit' => 'recipe#edit', as: 'edit_recipe'
  patch '/recipes/:id' => 'recipe#update'
  
  # request to see one instance
  get '/recipes/:id' => 'recipe#show', as: 'recipe'


end
