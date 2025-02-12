class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :resource_type
      t.integer :amount
      t.boolean :availability

      t.timestamps
    end
  end
end
