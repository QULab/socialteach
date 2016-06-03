class Course < ActiveRecord::Base
    
    has_many :chapters
    has_many :course_enrollments
end
