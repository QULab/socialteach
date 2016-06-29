class Course < ActiveRecord::Base

    has_many :chapters
    has_many :course_enrollments
    belongs_to :users
    has_one :feedback, as: :commentable

    has_many :activities, through: :chapters
end
