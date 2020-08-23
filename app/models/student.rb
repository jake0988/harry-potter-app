class Student < ActiveRecord::Base
    belongs_to :house
    has_many :student_cup_winners
    has_many :cup_winners, through: :student_cup_winners
    has_secure_password
end