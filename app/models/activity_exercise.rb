class ActivityExercise < ActiveRecord::Base
  has_one :activity, as: :content
  has_one :questionnaire, as: :qu_container

  accepts_nested_attributes_for :questionnaire
end
