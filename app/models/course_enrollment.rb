class CourseEnrollment < ActiveRecord::Base
  has_merit

  belongs_to :user
  belongs_to :course
  has_many :activitystatuses
end
