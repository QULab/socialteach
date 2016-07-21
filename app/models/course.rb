class Course < ActiveRecord::Base

  after_save :create_default_feedback
  after_create :create_default_chapter_and_assessment

  validate :cannot_unpublish_if_users_enrolled
  has_many :course_badges
  has_many :chapters
  has_many :course_enrollments
  belongs_to :users
  has_one :feedback, as: :commentable
  has_one :user, as: :creator

    has_many :activities, through: :chapters

    ##
    # returns the user who created this course as object
    def creator
      creator = User.find_by_id(self.creator_id)
    end

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

   def self.all_published_courses
     where(published: true)
   end

   def cannot_unpublish_if_users_enrolled
     if (published_was && get_number_of_enrollments > 0 && !published)
       self.errors[:base] << "There are Users enrolled in this course, you can not unpublish it."
     end
   end

   def create_default_feedback
     questionnaire = Questionnaire.create!(qu_container: Feedback.create!(commentable: self))
     question = questionnaire.m_questions.create!(text: 'How difficult was this unit?')
     questionId = question.id
     Answer.create(m_question_id: questionId, text: 'Too Easy')
     Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
     Answer.create(m_question_id: questionId, text: 'Too Hard')
   end

   def create_default_chapter_and_assessment
     chapter = self.chapters.create!(name: 'Default Chapter', shortname: 'Default', description: 'This is a defualt chapter, containing an initial assessment questionnaire. Feel free to change it', tier: 1)
     activity = chapter.activities.create!(name: 'Initial Assessment', shortname: 'Assessment', levelpoints: 5, tier: 1, content: ActivityAssessment.create!)
     Questionnaire.create!(qu_container: activity.content)
   end
end
