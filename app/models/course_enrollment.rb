class CourseEnrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :activity_statuses
end
