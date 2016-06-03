class Chapter < ActiveRecord::Base
    
    belongs_to :courses
    has_many :activities
end
