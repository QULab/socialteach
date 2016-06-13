class CompletedMQuestion < ActiveRecord::Base
  belongs_to :m_question
  belongs_to :answer
  belongs_to :user
end
