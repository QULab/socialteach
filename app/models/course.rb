class Course < ActiveRecord::Base

  validate :cannot_unpublish_if_users_enrolled

  has_many :chapters
  has_many :course_enrollments
  belongs_to :users
  has_one :feedback, as: :commentable


  has_many :activities, through: :chapters

  def get_number_of_enrollments
    CourseEnrollment.where("course_id = ?", self.id).count
  end

  def self.all_published_courses
    where(published: true)
  end

  def cannot_unpublish_if_users_enrolled
    if (published_was && get_number_of_enrollments > 0 && !published)
      self.errors[:base] << "There are Users enrolled in this course, you can not unpublish it."
    end
  end
end
