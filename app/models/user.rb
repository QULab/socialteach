class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
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
end
