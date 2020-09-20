class Favorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.integer :student_id
      t.string :band
      t.string :comment
      t.string :band_url

      t.timestamps null: false
    end
  end
end
