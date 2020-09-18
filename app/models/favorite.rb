class Favorite < ActiveRecord::Base
    validates :person, presence: true
    belongs_to :student
end