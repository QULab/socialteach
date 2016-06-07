class DifficultyFeedback < ActiveRecord::Base
  has_one :questionnaire, as: :qu_container
end
