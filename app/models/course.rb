class Course < ActiveRecord::Base
  has_many :lecture
end
