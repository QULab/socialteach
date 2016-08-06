##
# Represents the status of a chapter for a course enrollment.
class ChapterStatus < ActiveRecord::Base
  belongs_to :course_enrollment
  belongs_to :chapter
end
