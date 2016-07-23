class UnlockCourseBadge < ActiveRecord::Base
  belongs_to :course_badge
  belongs_to :activity
end
