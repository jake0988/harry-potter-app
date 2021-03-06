class Student < ActiveRecord::Base
    has_many :favorites
    belongs_to :house
    has_many :student_cup_winners
    has_many :cup_winners, through: :student_cup_winners
    has_secure_password
    validates :username, presence: true, uniqueness: true 
    validates :house, presence: true
    # def slug
    #     username.downcase.gsub(" ","-")
    #   end
    
    #   def self.find_by_slug(slug)
    #     Student.all.find{|student| student.slug == slug}
    #   end
    
end