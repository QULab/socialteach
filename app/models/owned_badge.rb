class OwnedBadge < ActiveRecord::Base
  belongs_to :course_badge
  belongs_to :course_enrollment
end
