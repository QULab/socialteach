class MQuestion < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :correct_answer, class_name: "Answer", :foreign_key => 'correct_answer_id'
  has_many :answers, dependent: :destroy # possible answers
  has_many :completed_m_questions

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: lambda { |a| a[:text].blank? }
end
