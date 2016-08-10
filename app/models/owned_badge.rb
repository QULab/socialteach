##
# Represents course badges unlocked by a user
# Assigned to a enrollment for user and course
class OwnedBadge < ActiveRecord::Base
  belongs_to :course_badge
  belongs_to :course_enrollment
end
