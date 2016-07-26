class Level < ActiveRecord::Base
	has_many :activities
	has_many :course_enrollments

	validates :level, :level_pass, numericality: {greater_than_or_equal_to: 0}
	validates :level, :level_pass, uniqueness: true
end
