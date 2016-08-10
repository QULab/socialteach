##
# Represents Level pool which is used for every level assigment (e.g. Activity, Enrollment, etc)
# Has to contain one elment before software used which is (level: 1 and level_pass: 0)!!!
class Level < ActiveRecord::Base
	has_many :activities
	has_many :course_enrollments

	validates :level, :level_pass, numericality: {greater_than_or_equal_to: 0}
	validates :level, :level_pass, uniqueness: true
end
