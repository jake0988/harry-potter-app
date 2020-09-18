class CupWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :cup_winners do |t|
      t.string :name
      t.integer :year
      t.integer :house_id
      t.timestamps null: false
    end
  end
end
