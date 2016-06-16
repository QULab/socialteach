class ActivityExcercise < ActiveRecord::Base
  has_one :activity, as: :content
  has_one :questionnaire, as: :qu_container
end
