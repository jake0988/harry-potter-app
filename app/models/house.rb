class House < ActiveRecord::Base
    has_many :students
    has_many :cup_winners
end