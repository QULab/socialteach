class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
    
  has_many :courses
  has_many :completed_m_questions
  has_many :completed_questionnaires

  validate :username_validation
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

end
