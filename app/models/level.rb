class Level < ActiveRecord::Base
	has_many :activities
	has_many :course_enrollments
end
