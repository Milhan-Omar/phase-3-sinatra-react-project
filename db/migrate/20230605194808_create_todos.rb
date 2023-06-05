class CreateTodos < ActiveRecord::Migration[6.1]
  def change
      create_table :todos do |t|
      t.string :description
      t.datetime :due
      t.boolean :status
      t.integer :user_id
    end
  end
end
