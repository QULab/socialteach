FactoryGirl.define do
  factory :course do
    name 'English for Beginners'
    description 'this course is for beginners'
    creator_id 1
      
      factory :other_course do
        name 'Spanish for advanced Students'
        description 'advanced students'
        creator_id 2 
      end
  end
    
end