FactoryGirl.define do
    
  factory :user do
      username 'Andreas'
      email 'andreas@gmail.com'
      password '123456'
      id '1'
      
     factory :user_instructor do
       is_instructor true
     end
  end
end