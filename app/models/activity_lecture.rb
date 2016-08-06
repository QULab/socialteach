##
# Represents a lecture in an activity.
# Lectures introduce and explain concepts.
# They can be formatted in Markdown or html
class ActivityLecture < ActiveRecord::Base
  has_one :activity, as: :content
  validates :text, presence: true
end
