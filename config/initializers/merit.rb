# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end

Merit::Badge.create!(
  id: 1,
  name: "5 Socialpoints",
  description: "Gained 5 socialpoints",
  custom_fields: {condition: 5, type: :social, image: "badge_1_5.png"}
)

Merit::Badge.create!(
  id: 2,
  name: "10 Socialpoints",
  description: "Gained 10 socialpoints",
  custom_fields: {condition: 10, type: :social, image: "badge_1_10.png"}
)

Merit::Badge.create!(
  id: 3,
  name: "25 Socialpoints",
  description: "Gained 25 socialpoints",
  custom_fields: {condition: 25, type: :social, image: "badge_1_25.png"}
)

Merit::Badge.create!(
  id: 4,
  name: "50 Socialpoints",
  description: "Gained 50 socialpoints",
  custom_fields: {condition: 50, type: :social, image: "badge_1_50.png"}
)

Merit::Badge.create!(
  id: 5,
  name: "100 Socialpoints",
  description: "Gained 100 socialpoints",
  custom_fields: {condition: 100, type: :social, image: "badge_1_100.png"}
)

Merit::Badge.create!(
  id: 6,
  name: "5 Learningpoints",
  description: "Gained 5 learningpoints",
  custom_fields: {condition: 5, type: :learning, image: "badge_2_5.png"}
)

Merit::Badge.create!(
  id: 7,
  name: "10 Learningpoints",
  description: "Gained 10 learningpoints",
  custom_fields: {condition: 10, type: :learning, image: "badge_2_10.png"}
)

Merit::Badge.create!(
  id: 8,
  name: "25 Learningpoints",
  description: "Gained 25 learningpoints",
  custom_fields: {condition: 25, type: :learning, image: "badge_2_25.png"}
)

Merit::Badge.create!(
  id: 9,
  name: "50 Learningpoints",
  description: "Gained 50 learningpoints",
  custom_fields: {condition: 50, type: :learning, image: "badge_2_50.png"}
)

Merit::Badge.create!(
  id: 10,
  name: "100 Learningpoints",
  description: "Gained 100 learningpoints",
  custom_fields: {condition: 100, type: :learning, image: "badge_2_100.png"}
)

Merit::Badge.create!(
  id: 11,
  name: "5 Activities",
  description: "Completed successfully 5 Activities",
  custom_fields: {condition: 5, type: :activities, image: "badge_3_5.png"}
)

Merit::Badge.create!(
  id: 12,
  name: "10 Activities",
  description: "Completed successfully 10 Activities",
  custom_fields: {condition: 10, type: :activities, image: "badge_3_10.png"}
)

Merit::Badge.create!(
  id: 13,
  name: "25 Activities",
  description: "Completed successfully 25 Activities",
  custom_fields: {condition: 25, type: :activities, image: "badge_3_25.png"}
)

Merit::Badge.create!(
  id: 14,
  name: "50 Activities",
  description: "Completed successfully 50 Activities",
  custom_fields: {condition: 50, type: :activities, image: "badge_3_50.png"}
)

Merit::Badge.create!(
  id: 15,
  name: "100 Activities",
  description: "Completed successfully 100 Activities",
  custom_fields: {condition: 100, type: :activities, image: "badge_3_100.png"}
)