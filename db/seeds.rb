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

user1 = User.create(email: 'user1@test.com', username: 'User 1', password: 'password', password_confirmation: 'password')
user2 = User.create(email: 'user2@test.com', username: 'User 2', password: 'password', password_confirmation: 'password')
user3 = User.create(email: 'user3@test.com', username: 'User 3', password: 'password', password_confirmation: 'password')
user4 = User.create(email: 'user4@test.com', username: 'User 4', password: 'password', password_confirmation: 'password')
user5 = User.create(email: 'user5@test.com', username: 'User 5', password: 'password', password_confirmation: 'password')
user6 = User.create(email: 'user6@test.com', username: 'User 6', password: 'password', password_confirmation: 'password')
user7 = User.create(email: 'user7@test.com', username: 'User 7', password: 'password', password_confirmation: 'password')
user8 = User.create(email: 'user8@test.com', username: 'User 8', password: 'password', password_confirmation: 'password')
user9 = User.create(email: 'user9@test.com', username: 'User 9', password: 'password', password_confirmation: 'password')
user10 = User.create(email: 'user10@test.com', username: 'User 10', password: 'password', password_confirmation: 'password')
user11 = User.create(email: 'qu.socialteach@gmail.com', username: 'Duc', password: 'password', password_confirmation: 'password')



# Course with Chapters and Activities
course = Course.create!(name: 'Italian for Beginners', published: true, description: 'A course for people with no prior knowledge of the Italian language', creator_id: instructor.id)
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

act1 = Activity.create!(name: 'Hello World to You', levelpoints: '2', tier: '2', shortname: 'Hello', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example"), level: level1)
act2 = Activity.create!(name: 'Now you!', levelpoints: '2', tier: '3', shortname: 'You', chapter_id: chap1Id, content: ActivityLecture.new(text: "Example 2"), level: level2)
exercise = ActivityExercise.create
act3 = Activity.create!(name: 'Test yourself with a Questionnaire', levelpoints: '3', tier: '3', shortname: 'Test', chapter_id: chap1Id, content: exercise, level: level2)
assessment = ActivityAssessment.create
act4 = Activity.create!(name: 'Knowledge Assessment', levelpoints: '2', tier: '1', shortname: 'Test', chapter_id: chap1Id, content: assessment, level: level1)

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
questionnaire = Questionnaire.create(qu_container: exercise)
question1 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'What was the name of the first Activity?')
question1Id = question1.id
answer1 = Answer.create(m_question_id: question1Id, text: 'Tell me who you are')
answer2 = Answer.create(m_question_id: question1Id, text: 'Shopping by Numbers', correct: true)
answer3 = Answer.create(m_question_id: question1Id, text: 'Hello World to You')
answer4 = Answer.create(m_question_id: question1Id, text: 'Hello World in Italian')

question2 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'What was the name of the second Activity?')
question2Id = question2.id
answer1 = Answer.create(m_question_id: question2Id, text: 'Now you!', correct: true)
answer2 = Answer.create(m_question_id: question2Id, text: 'Shopping by Numbers')

# Add questionnaire to act4
questionnaire = Questionnaire.create(qu_container: assessment)
question1 = MQuestion.create(questionnaire_id: questionnaire.id, text: "What is 'language' in Italian")
question1Id = question1.id
answer1 = Answer.create(m_question_id: question1Id, text: 'cane')
answer2 = Answer.create(m_question_id: question1Id, text: 'otto volante')
answer3 = Answer.create(m_question_id: question1Id, text: 'lingua', correct: true)
answer4 = Answer.create(m_question_id: question1Id, text: 'patata')

question2 = MQuestion.create(questionnaire_id: questionnaire.id, text: 'Italy looks like a...?')
question2Id = question2.id
answer1 = Answer.create(m_question_id: question2Id, text: 'Boot', correct: true)
answer2 = Answer.create(m_question_id: question2Id, text: 'Cat')

# Difficulty feedback for act1
feedback = Feedback.create(commentable: act1)
questionnaire = Questionnaire.create(qu_container: feedback)
feedback_question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
feedback_questionId = feedback_question.id
answer1 = Answer.create(m_question_id: feedback_questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: feedback_questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: feedback_questionId, text: 'Too Hard')

# Given feedback for course
questionnaire = course.feedback.questionnaire
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user8.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user8.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user1.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user1.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user2.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user2.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user3.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer2.id, user_id: user3.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user9.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer2.id, user_id: user9.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user4.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user4.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user5.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user5.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user6.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user6.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user7.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user7.id)


# Given feedback for course
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user8.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user8.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user1.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user1.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user2.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer1.id, user_id: user2.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user3.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer2.id, user_id: user3.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user9.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer2.id, user_id: user9.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user4.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user4.id)
cq = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user5.id)
CompletedMQuestion.create(completed_questionnaire_id: cq.id, m_question_id: feedback_questionId, answer_id: answer3.id, user_id: user5.id)

# Difficulty feedback for act3
feedback = Feedback.create(commentable: act3)
questionnaire = Questionnaire.create(qu_container: feedback)
question = MQuestion.create(questionnaire_id: questionnaire.id, text: 'How difficult was this unit?')
questionId = question.id
answer1 = Answer.create(m_question_id: questionId, text: 'Too Easy')
answer2 = Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
answer3 = Answer.create(m_question_id: questionId, text: 'Too Hard')
