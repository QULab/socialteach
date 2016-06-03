class Course < ActiveRecord::Base
    
    has_many :chapters
end
