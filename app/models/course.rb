class Course < ActiveRecord::Base

    has_many :chapters
    has_many :course_enrollments
    belongs_to :users
    has_one :feedback, as: :commentable


    has_many :activities, through: :chapters

    def get_number_of_enrollments
      CourseEnrollment.where("course_id = ?", self.id).count
    end
end
