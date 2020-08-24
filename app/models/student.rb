class Student < ActiveRecord::Base
    belongs_to :house
    has_many :student_cup_winners
    has_many :cup_winners, through: :student_cup_winners
    has_secure_password

    def slug
        username.downcase.gsub(" ","-")
      end
    
      def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
      end
    
end