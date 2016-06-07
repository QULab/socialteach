class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
  has_many :courses
    
  validate :username_validation

    def username_validation
          
      if !username.present?
          errors.add :username, "can't be blank!"
          
      elsif username.length > 12
          errors.add :username, "The user name should have more than 5 letters!"
      end
  end
end
