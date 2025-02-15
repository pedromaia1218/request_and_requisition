class AddCategoriesToResources < ActiveRecord::Migration[7.1]
  def change
    add_reference :resources, :categories, foreign_key: true
  end
end
