class CreateInstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :instructions do |t|
      t.text :process
      t.integer :recipe_id

      t.timestamps
    end
  end
end
