class User < ActiveRecord::Base
  acts_as_voter

  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :courses
  has_many :completed_m_questions
  has_many :completed_questionnaires
  validate :username_validation
  has_many :course_enrollments
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :created_badges, :class_name => "CourseBadge", :foreign_key => "user_id"

  def username_validation
    if !username.present?
      errors.add :username, "can't be blank!"
    elsif username.length > 20
      errors.add :username, "The user name should not have more than 20 letters!"
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, userid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.userid = auth.uid
      user.username = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attribbutes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # this method accepts either a course object or a course_id
  def is_enrolled?(course)
    if course.is_a?(Course)
      return CourseEnrollment.where("user_id = ? AND course_id = ?", self.id, course.id).exists?
    else
      return CourseEnrollment.where("user_id = ? AND course_id = ?", self.id, course).exists?
    end
  end

  # this method accepts either a course object or a course_id
  def get_enrollment(course)
    if course.is_a?(Course)
      enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", self.id, course.id).first
    else
      enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", self.id, course).first
    end
    return enrollment
  end

  def completed?(activity)
    enrollment = self.get_enrollment(activity.course)
    return ActivityStatus.where(activity_id: activity.id,course_enrollment_id: enrollment.id, is_completed: true).exists?
  end

  def completed_successfull?(activity)
    enrollment = self.get_enrollment(activity.course)
    status = ActivityStatus.where("activity_id = ? AND course_enrollment_id = ?", activity.id, enrollment.id).order("created_at").last
    unless status.nil?
      status.status == ActivityStatus.successfull
    else
      false
    end
  end

  def get_created_courses
    unless self.is_instructor
      return nil
    else
      return Course.where("creator_id = ?", self.id).to_a
    end
  end

end
