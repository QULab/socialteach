class Course < ActiveRecord::Base

    has_many :chapters
    has_many :course_enrollments
    belongs_to :users
    has_one :feedback, as: :commentable

    has_many :activities, through: :chapters

    # returns the number of enrollments for this course
    def get_number_of_enrollments
      CourseEnrollment.where("course_id = ?", self.id).count
    end

    # returns the number of enrollments that are completed
    def get_number_of_completed_enrollments
      CourseEnrollment.where("course_id = ? AND completed = ?", self.id, true).count
    end

    # returns the number of enrollments for this course created in the last x days
    def get_number_of_new_enrollments(days)
      CourseEnrollment.where("course_id = ? AND created_at >= ?", self.id, Time.now - days.day).count
    end
end
