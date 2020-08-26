class CupWinner < ActiveRecord::Base
    belongs_to :house
    has_many :student_cup_winners
    has_many :students, through: :student_cup_winners
end