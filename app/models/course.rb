class Course < ActiveRecord::Base
    
    has_many :chapters
    has_many :course_enrollments
    belongs_to :users
end
