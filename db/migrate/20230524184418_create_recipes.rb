class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :chef
      t.string :cuisine

      t.timestamps
    end
  end
end
