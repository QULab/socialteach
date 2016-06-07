class ActivityStatus < ActiveRecord::Base
	belongs_to :activity
	belongs_to :course_enrollment
end
