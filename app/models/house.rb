class Student < ActiveRecord::Base
    has_many :students
    has_many :house_cup_winners
    has_many :cup_winners, through: :house_cup_winners
end