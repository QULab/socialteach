class Activity < ActiveRecord::Base
	belongs_to :chapter
	has_many :activity_statuses
end
