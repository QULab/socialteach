class MultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :answers, :class_name => 'Answer'
  has_one :correct_answer, :class_name => 'Answer
end
