class CourseBadge < ActiveRecord::Base
	belongs_to :course
	belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

	mount_uploader :badge, BadgeUploader

	validate :check_badge_dimensions

	def check_badge_dimensions
	    ::Rails.logger.info "Avatar upload dimensions: #{self.width}x#{self.height}"
	    errors.add :avatar, "Dimensions of uploaded avatar should be exactly 80x80 pixels." if self.width != 80 && height != 80
	end
end
