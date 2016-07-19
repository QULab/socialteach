class CourseBadge < ActiveRecord::Base
	belongs_to :course
	belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'
	has_many :unlock_course_badges
	has_many :owned_badges
	has_many :activities, through: :unlock_course_badges
	has_many :users, through: :owned_badges

	accepts_nested_attributes_for :unlock_course_badges, :allow_destroy => true

	mount_uploader :badge, BadgeUploader

	validate :check_badge_dimensions

	def check_badge_dimensions
	    ::Rails.logger.info "Avatar upload dimensions: #{self.width}x#{self.height}"
	    errors.add :avatar, "Dimensions of uploaded avatar should be exactly 80x80 pixels." if self.width != 80 && height != 80
	end
end
