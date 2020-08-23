class StudentCupWinner < ActiveRecord::Base
    belongs_to :cup_winner
    belongs_to :student
end