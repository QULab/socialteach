class CompletedQuestionnairesController < ApplicationController
  def create
    # TODO: the id of the default feedback needs to go in a config file
    questionnaire = Feedback.find(1).questionnaire
    user_id = current_user.id
    CompletedMQuestion.create(m_question_id: questionnaire.m_questions.first.id,
                              user_id: user_id,
                              answer_id: params[:answer])

    CompletedQuestionnaire.create(questionnaire_id: questionnaire.id,
                                  user_id: user_id)
    head :no_content
  end
end
