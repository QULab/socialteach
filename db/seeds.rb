# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Users
user = User.create!({
  email: "test@test.com",
  username: "Test",
  password: "password",
  password_confirmation: "password",
})

# Course with Chapters and Activities
course = Course.create!(name: 'Italian for Beginners', description: 'A course for people with no prior knowledge of the Italian language')
courseId = course.id

chap1 = Chapter.create(name: 'Hello World in Italian', shortname: 'Hello', description: 'Our first Sentence!', tier: 1, course_id: courseId)
chap1Id = chap1.id
chap2 = Chapter.create(name: 'Tell me who you are', shortname: 'You', description: 'How to introduce yourself', tier: 2, course_id: courseId)
chap3 =Chapter.create(name: 'The most important chapter: Food', shortname: 'Food', description: 'How to order delicious Italian food', tier: 2, course_id: courseId)
chap4 =Chapter.create(name: 'Becoming a professional Tourist', shortname: 'Tourism', description: 'How to get the most out of a visit to Italy by asking the right questions', tier: 3, course_id: courseId)
chap5 =Chapter.create(name: 'Shopping by the Numbers', shortname: 'Shopping', description: 'All about shopping and of course the most important thing to know about: Numbers!', tier: 4, course_id: courseId)

level1 = Level.create(level: 1, level_pass: 0)
level2 = Level.create(level: 2, level_pass: 100)
level3 = Level.create(level: 3, level_pass: 200)

act1 = Activity.create!(name: 'Hello World to You', levelpoints: '2', tier: '1', shortname: 'Hello', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example"), level: level1)
act2 = Activity.create!(name: 'Now you!', levelpoints: '2', tier: '2', shortname: 'You', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example 2"), level: level2)

course_e = CourseEnrollment.create(active: true, is_visible: true, user: user, course: course, level: level1)

# add structure for Chapters
chap2.predecessors = [chap1]
chap3.predecessors = [chap1]
chap4.predecessors = [chap2, chap3]
chap5.predecessors = [chap4]

#add structure to Activities
act2.predecessors = [act1]

# Difficulty feedback
feedback = Feedback.create(commentable: act1)

questionnaire = Questionnaire.create(qu_container: feedback)

question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
questionId = question.id

answer1 = Answer.create(m_question_id: questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: questionId, text: 'Too Hard')
