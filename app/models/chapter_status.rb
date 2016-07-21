class ChapterStatus < ActiveRecord::Base
  belongs_to :course_enrollment
  belongs_to :chapter
end
