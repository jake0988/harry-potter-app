class Favorite < ActiveRecord::Base
    validates :band, presence: true
    belongs_to :student
end