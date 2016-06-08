class CompletedMCQuestion < ActiveRecord::Base
  belongs_to :mc_question
  belongs_to :answer
  belongs_to :user
end
