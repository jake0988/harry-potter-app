class HouseCupWinner < ActiveRecord::Base
    belongs_to :cup_winner
    belongs_to :house
end