class CupWinner < ActiveRecord::Base
    has_many :house_cup_winners
    has_many :houses, through: :house_cup_winners
    has_many :student_cup_winers
    has_many :students, through: :student_cup_winers
end