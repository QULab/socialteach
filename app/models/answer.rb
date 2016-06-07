class Answer < ActiveRecord::Base
  belongs_to :multiple_choice_question
  belongs_to :answered_question, :class_name => "MultipleChoiceQuestion"
end
