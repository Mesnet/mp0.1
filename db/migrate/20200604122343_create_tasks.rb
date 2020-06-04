class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.datetime :done_at
      t.integer :done_by, foreign_key: true
      t.integer :parent_id, foreign_key: true
      t.integer :position
      t.boolean :activ, default: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
