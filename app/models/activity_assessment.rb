##
# Represents an assessment in an activity. Assessments contain a questionnaire.
# Assessments can be used to assess a user's existing knowledge.
class ActivityAssessment < ActiveRecord::Base
  has_one :activity, as: :content
  has_one :questionnaire, as: :qu_container

  accepts_nested_attributes_for :questionnaire, allow_destroy: true
end
