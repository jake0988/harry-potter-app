class StudentCupWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :student_cup_winners do |t|
      t.integer :student_id
      t.integer :cup_winner_id
      t.timestamps null: false
    end
  end
end
