class CreateRequest < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :priority
      t.references :resource, foreign_key: true, null: false
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :assigned_to, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
''
