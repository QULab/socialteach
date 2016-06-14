FactoryGirl.define do
  factory :user do
      username 'Andreas'
      email 'andreas@gmail.com'
      password '123456'
      is_instructor true
      id '1'
  end
end