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

instructor = User.create(email: 'instructor@test.com', username: 'Instructor', password: 'password', password_confirmation: 'password', is_instructor: true)

# Course with Chapters and Activities
course = Course.create!(name: 'Italian for Beginners', description: 'A course for people with no prior knowledge of the Italian language', creator_id: instructor.id)
courseId = course.id

chap1 = Chapter.create(name: 'Hello World in Italian', shortname: 'Hello', description: 'Our first Sentence!', tier: 1, course_id: courseId)
chap1Id = chap1.id
chap2 = Chapter.create(name: 'Tell me who you are', shortname: 'You', description: 'How to introduce yourself', tier: 2, course_id: courseId)
chap3 =Chapter.create(name: 'The most important chapter: Food', shortname: 'Food', description: 'How to order delicious Italian food', tier: 2, course_id: courseId)
chap4 =Chapter.create(name: 'Becoming a professional Tourist', shortname: 'Tourism', description: 'How to get the most out of a Merit to Italy by asking the right questions', tier: 3, course_id: courseId)
chap5 =Chapter.create(name: 'Shopping by the Numbers', shortname: 'Shopping', description: 'All about shopping and of course the most important thing to know about: Numbers!', tier: 4, course_id: courseId)

act1 = Activity.create!(name: 'Hello World to You', levelpoints: '2', tier: '2', shortname: 'Hello', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example"))
act2 = Activity.create!(name: 'Now you!', levelpoints: '2', tier: '3', shortname: 'You', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example 2"))
excercise = ActivityExcercise.create
act3 = Activity.create!(name: 'Test yourself with a Questionnaire', levelpoints: '3', tier: '3', shortname: 'Test', chapter_id: chap1Id, content: excercise)
assessment = ActivityAssessment.create
act4 = Activity.create!(name: 'Knowledge Assessment', levelpoints: '2', tier: '1', shortname: 'Test', chapter_id: chap1Id, content: assessment)

# add structure for Chapters
chap2.predecessors = [chap1]
chap3.predecessors = [chap1]
chap4.predecessors = [chap2, chap3]
chap5.predecessors = [chap4]

#add structure to Activities
act1.predecessors = [act4]
act2.predecessors = [act1]
act3.predecessors = [act1]

# Add questionnaire to act3
questionnaire = Questionnaire.create(qu_container: excercise)
question1 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'What was the name of the first Activity?')
question1Id = question1.id
answer1 = Answer.create(m_question_id: question1Id, text: 'Tell me who you are')
answer2 = Answer.create(m_question_id: question1Id, text: 'Shopping by Numbers')
answer3 = Answer.create(m_question_id: question1Id, text: 'Hello World to You')
answer4 = Answer.create(m_question_id: question1Id, text: 'Hello World in Italian')
question1.update(correct_answer_id: answer3.id)

question2 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'What was the name of the second Activity?')
question2Id = question2.id
answer1 = Answer.create(m_question_id: question2Id, text: 'Now you!')
answer2 = Answer.create(m_question_id: question2Id, text: 'Shopping by Numbers')
question2.update(correct_answer_id: answer1.id)

# Add questionnaire to act4
questionnaire = Questionnaire.create(qu_container: assessment)
question1 = MQuestion.create(questionnaire_id: questionnaire.id, text: "What is 'language' in Italian")
question1Id = question1.id
answer1 = Answer.create(m_question_id: question1Id, text: 'cane')
answer2 = Answer.create(m_question_id: question1Id, text: 'otto volante')
answer3 = Answer.create(m_question_id: question1Id, text: 'lingua')
answer4 = Answer.create(m_question_id: question1Id, text: 'patata')
question1.update(correct_answer_id: answer3.id)

question2 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'Italy looks like a...?')
question2Id = question2.id
answer1 = Answer.create(m_question_id: question2Id, text: 'Boot')
answer2 = Answer.create(m_question_id: question2Id, text: 'Cat')
question2.update(correct_answer_id: answer1.id)

# Difficulty feedback for act1
feedback = Feedback.create(commentable: act1)
questionnaire = Questionnaire.create(qu_container: feedback)
feedback_question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
feedback_questionId = feedback_question.id
answer1 = Answer.create(m_question_id: feedback_questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: feedback_questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: feedback_questionId, text: 'Too Hard')

# Difficulty feedback for course
feedback = Feedback.create(commentable: course)
questionnaire = Questionnaire.create(qu_container: feedback)
question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
questionId = question.id
answer1 = Answer.create(m_question_id: questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: questionId, text: 'Too Hard')

# Difficulty feedback for act3
feedback = Feedback.create(commentable: act3)
questionnaire = Questionnaire.create(qu_container: feedback)
question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
questionId = question.id
answer1 = Answer.create(m_question_id: questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: questionId, text: 'Too Hard')


Merit.delete_all
Merit.create  course: 'United States', earned_at: DateTime.now, points: 350
Merit.create  course: 'United States', earned_at: DateTime.now, points: 150
Merit.create  course: 'United States', earned_at: DateTime.now, points: 100
Merit.create  course: 'United States', earned_at: DateTime.now - 1.day, points: 405
Merit.create  course: 'United States', earned_at: DateTime.now - 1.day, points: 400
Merit.create  course: 'United States', earned_at: DateTime.now - 2.days, points: 300
Merit.create  course: 'United States', earned_at: DateTime.now - 2.days, points: 100
Merit.create  course: 'United States', earned_at: DateTime.now - 2.days, points: 305
Merit.create  course: 'United States', earned_at: DateTime.now - 3.days, points: 450
Merit.create  course: 'United States', earned_at: DateTime.now - 3.days, points: 300
Merit.create  course: 'Germany', earned_at: DateTime.now, points: 100
Merit.create  course: 'Germany', earned_at: DateTime.now, points: 200
Merit.create  course: 'Germany', earned_at: DateTime.now, points: 100
Merit.create  course: 'Germany', earned_at: DateTime.now, points: 300
Merit.create  course: 'Germany', earned_at: DateTime.now - 1.day, points: 400
Merit.create  course: 'Germany', earned_at: DateTime.now - 2.days, points: 200
Merit.create  course: 'Germany', earned_at: DateTime.now - 2.days, points: 100
Merit.create  course: 'Germany', earned_at: DateTime.now - 2.days, points: 300
Merit.create  course: 'Germany', earned_at: DateTime.now - 3.days, points: 305
Merit.create  course: 'South Korea', earned_at: DateTime.now, points: 200
Merit.create  course: 'South Korea', earned_at: DateTime.now, points: 250
Merit.create  course: 'South Korea', earned_at: DateTime.now, points: 100
Merit.create  course: 'South Korea', earned_at: DateTime.now, points: 150
Merit.create  course: 'South Korea', earned_at: DateTime.now - 1.day, points: 205
Merit.create  course: 'South Korea', earned_at: DateTime.now - 1.day, points: 400
Merit.create  course: 'South Korea', earned_at: DateTime.now - 1.day, points: 300
Merit.create  course: 'South Korea', earned_at: DateTime.now - 2.days, points: 100
Merit.create  course: 'South Korea', earned_at: DateTime.now - 3.days, points: 500
Merit.create  course: 'South Korea', earned_at: DateTime.now - 3.days, points: 400
Merit.create  course: 'South Korea', earned_at: DateTime.now - 3.days, points: 500
