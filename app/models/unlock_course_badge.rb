##
# Represents conditions to unlock course badge
# To unlock course badge all conditions have to be fulfilled
class UnlockCourseBadge < ActiveRecord::Base
  belongs_to :course_badge
  belongs_to :activity
end
