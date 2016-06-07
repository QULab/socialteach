class CompletedMultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :multiple_choice_question
  belongs_to :answer
  belongs_to :user
end
