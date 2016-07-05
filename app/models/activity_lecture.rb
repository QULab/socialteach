class ActivityLecture < ActiveRecord::Base
  has_one :activity, as: :content
  validates :text, presence: true
end
