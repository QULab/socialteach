class ActivityLecture < ActiveRecord::Base
  has_one :activity, as: :content
end
