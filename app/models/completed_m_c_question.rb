class CompletedMCQuestion < ActiveRecord::Base
  belongs_to :m_c_question
  belongs_to :answer
  belongs_to :user
end
