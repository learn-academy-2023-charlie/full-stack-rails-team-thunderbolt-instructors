## helpful terminal commands
- To see a list of available routes: $ `rails routes -E`
- To stop server: `control + c`

## Setup while using a github classroom link with an empty repo
***
Empty Github Repo - Only one team member performs these actions.
***
- Click on the project link in the slack channel
- Create team name and accept the assignment
- An empty github repo will be available
***NOTE: Do not clone this repo. This repo is meant to store the separate rails app that you will create.***
***
Rails App - Only one team member performs these actions.
***
***NOTE: Ensure you are not inside of a github repo when creating the rails app.***
- Create a new Rails app on the desktop directory: $ `rails new <app_name> -d postgresql -T`
- $ `cd <app_name>`
- Create a database: $ `rails db:create`
- Add the git remote add origin command from the empty repo in GitHub. This command will allow github to start tracking changes to your rails proect. The command will be under the heading `…or push an existing repository from the command line`
  - Example --> git remote add origin https://github.com/learn-academy-2023-charlie/full-stack-rails-team-thunderbolt-instructors.git
- Create a main branch: $ `git checkout -b main`
- Make an initial commit to the main branch:
  - $ git status
  - $ git add .
  - $ git commit -m 'initial commit'
  - $ git push origin main
***
- Refresh github website to see that it is now tracking the rails project
- Any additional changes will be saved on a new branch
***
All other team members
***
After first team member has performed actions for empty github repo and rails app
- Click on the project link in the slack channel
- Join the team created by first team member
- Clone the repo onto desktop directory

## Process
***NOTE: Create a branch for each feature added to the application***
- Push changes and merge to main after completing each user story/feature branch  
- controller is located at 
## branch: database-setup
- Add the dependencies for RSpec:
  - $ `bundle add rspec-rails`
  - $ `rails generate rspec:install`
- Generate the model with appropriate columns and data types: $ `rails generate model Recipe chef:string cuisine:string`
- Save changes to db schema: $ rails db:migrate
- Generate the controller with same name as model: $ `rails generate controller Recipe`
- Begin the rails server to see if application is built correctly: $ `rails server`
- In a browser navigate to: http://localhost:3000
- Add new instances to the database using rails console:
  - $ `rails console`
  > Recipe.create(chef: "Tucker and Scott", cuisine: "chicken picatta")

## Work flow 
The following files and folders will be to modified to add restful routes and crud actions:
1. controller (found at app/controllers/recipe_controller.rb)
2. routes (found at config/routes.rb)
3. views (found at app/views/recipe)

## branch: index
read -> get -> index
- controller: contains the index method that holds the active record queries to show all the instances
```rb
  def index
    @recipes = Recipe.all
  end
```
- routes: defines the url with `get` and calls the index method
```rb
  get '/recipes' => 'recipe#index', as: 'recipes'
```
- views: create index.html.erb which will iterate across the array containing all the instances within the database and then display each instance as a separate line item
```html.erb
  <h1>Charlie ShmorgishBoard of Recipes</h1>
  <ul>
    <% @recipes.each do |recipe|%>
      <li>
        Recipe for <%= recipe.cuisine %> by <%= recipe.chef %> 
      </li>
    <% end%>
  </ul>
```


## branch: show
read -> get -> show
- controller: contains show method that holds the active record queries to show a specific instance, therefore, needs a param to identify that instance. 
  - use params to dynamically pass the id for each instance
- routes: defines the url with `get` and calls the show method
- views: create show.html.erb which will display the chef and cuisine of each instance

## branch: create
- to save a new instance to the database, we need to provide an html form to collect the user's input (new) and then save those attributes as a new instance to the database (create)
### new
read -> get -> new
- controller: contains the new method that will be used to display a form to collect user input 
- routes: defines the url with `get` and calls the new method
- views: create new.html.erb which display an empty html form with labels named as key of each value in an instance
### create
create -> post -> create
- controller: contains the create method that will used to save a new instance to the database
- routes: defines the url with `post` and calls the create method
- views: no file needed, views handled by redirect_to helper method
- additional tools needed for create:
  - private: prevents access to certain data across the application
  - strong params: method listed as private to control what attributes can be created or updated for an instance 
```rb
  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.valid?
      redirect_to recipes_path
    else
      redirect_to new_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:chef, :cuisine)
  end
```

## branch: update
- to modify an existing instance to the database, we need to provide an html form that shows the current values that can be changed (edit) and then save those changes to the instance (update)
### edit
read -> get -> edit
- controller: contains the edit method that will specify which instance to display on the html form
- routes: defines the url with `get` and calls the edit method
- views:
## update
- controller: contains the update method that will save the changes to the database
- routes: defines the url with `patch` and calls the update method
- views: no file needed, views handled by redirect_to helper method
- also uses strong params
```rb
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if @recipe.valid?
      # redirect to the show page sending the query to identify the instance
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path
    end
  end
```

***additional notes***
## branch: links
- landing page does not have an alias
- new page has an alias
- show page has an alias that requires a param
```html.erb
  <%= link_to 'Home', '/' %>
  <%= link_to 'Add a Recipe', new_path %>
  <%= link_to 'See this Recipe', recipe_path(recipe) %>
```

## branch: destroy
delete -> delete -> destroy
- reference I used: [Destroy Method](https://learn.co/lessons/delete-forms-rails)
- controller: contains the destroy method that will remove an instance from the database
- routes: defines the url with `delete` and calls the destroy method
- views: no file needed, views handled by redirect_to helper method
- additional tool needed for destroy:
  - button to perform delete request
  - button will be placed on show.html.erb
  - `button_to` takes in three arguments string for title of button, path to the view to be displayed, and method to state the http verb
```html.erb
  <%= button_to 'Delete Recipe', recipe_path(@recipe), method: :delete %>
```  

## display all records in ascending order
```rb
  def index
    @recipes = Recipe.all.order('id')
  end
```

## table on views with links on cuisine
```html.erb
  <table border=1>
    <tr>
      <th>Chef</th>
      <th>Cuisine</th>
    </tr>
    <% @recipes.each do |recipe| %>
      <tr>
        <td>
          <%= recipe.chef %>
        </td>
        <td>
          <%= link_to recipe.cuisine, recipe_path(recipe) %>
        </td>
      </tr>
    <% end %>
  </table>
```

## Associations
- $ rails generate model Instruction ingredients:text process:text recipe_id:integer
- establish has_many/belongs_to relationships on the model class
- $ rails db:migrate
- $ rails g controller Instruction
- $ rails c
> suri = Recipe.find 2
> suri.instructions.create(ingredients: '1 egg white, 1/2 cup granulated sugar plus more for the top crust, 1/2 cup brown sugar packed, 3 tablespoons all-purpose flour, 1 teaspoon ground cinnamon, 1/4 teaspoon ground ginger, 1/4 teaspoon ground nutmeg, 6 to 7 cups tart apples peeled and thinly sliced, 1 tablespoon lemon juice, 2 9-inch pie crusts thawed (homemade or from 1 box store-bought), 1 tablespoon butter',process: 'Preheat oven to 375 degrees. In a small mixing bowl, mix the white sugar, brown sugar, flour, cinnamon, ginger, and nutmeg. Set aside. In a large mixing bowl, toss apples with lemon juice. Sprinkle in sugar mixture and toss to evenly coat. Lay one pie crust in bottom of 9-inch pie pan, trimming the pastry even with the edge of the pan. Spoon in the apple mixture into the pie and place butter piece on top. Roll the remaining crust out. Set crust over the filling and trim as necessary to fit the top of the pie. Seal, flute the edges, and cut slits in the pastry. Beat egg white until foamy; brush over pastry. Sprinkle with sugar. Cover edges loosely with foil. Bake for 25 minutes. Remove foil and bake until crust is golden brown and pie filling is bubbling, about 20 minutes more. Cool on wire rack.')
- app/controllers/instruction_controller.rb
```rb
  def index
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
  end
```
- routes
# request to see all instructions associated with a specific recipe
`get '/recipes/:id/instructions' => 'instruction#index', as: 'process'`

- views/instruction/index.html.erb
```html.erb
  <% @instructions.each do |instruction|%>
    <h2>
      Ingredients: <%= instruction.ingredients %>  
    </h2>
    <h2>
      Process: <%= instruction.process %>
    </h2>
  <% end%>
```
- update link for cuisine on the recipe index page to go to instruction index page
`<%= link_to recipe.cuisine, process_path(recipe) %>`


