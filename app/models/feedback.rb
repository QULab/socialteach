##
# Returns a feedback containing a questionnaire.
class Feedback < ActiveRecord::Base
  has_one :questionnaire, as: :qu_container

  # Belong to Unit: Activity, Chapter, or Course
  belongs_to :commentable, polymorphic: true
end
