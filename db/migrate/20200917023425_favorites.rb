class Favorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.integer :student_id
      t.string :person
      t.string :comment

      t.timestamps null: false
    end
  end
end
