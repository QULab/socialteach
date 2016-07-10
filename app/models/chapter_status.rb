class ChapterStatus < ActiveRecord::Base
  belongs_to :course_enrollment
end
