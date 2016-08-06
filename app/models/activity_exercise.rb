##
# Represents an exercise in a activity. Exercises contain a questionnaire.
# An Exercise can be used to check a user's understanding of topics and to provide interactive content.
class ActivityExercise < ActiveRecord::Base
  has_one :activity, as: :content
  has_one :questionnaire, as: :qu_container

  accepts_nested_attributes_for :questionnaire, allow_destroy: true
end
