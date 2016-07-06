class ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :complete, :feedback]


  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  def complete
    unless current_user.completed?(@activity)
      if @activity.content.is_a?(ActivityExercise) || @activity.content.is_a?(ActivityAssessment)
        questionnaire = @activity.content.questionnaire
        user_id = current_user.id

        cquestionnaire = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user_id)
        questionnaire.m_questions.each_with_index do |question, i|
          CompletedMQuestion.create(m_question_id: question.id,
                                    completed_questionnaire_id: cquestionnaire.id,
                                    user_id: user_id,
                                    answer_id: params[:question][i.to_s.to_sym][:answer_id])
        end
      end
      enrollment = current_user.get_enrollment(@activity.course)
      status = ActivityStatus.new({is_completed: true, course_enrollment: enrollment, activity: @activity})
      status.save
      redirect_to curriculum_course_path(@activity.course) , notice: 'Congratulations, you finished this Activity!'
    else
      redirect_to curriculum_course_path(@activity.course) , notice: 'You already finished this activity before!'
    end
  end

  # POST /activities/1/feedback
  def feedback
    questionnaire = @activity.feedback.questionnaire
    user_id = current_user.id
    CompletedMQuestion.create(m_question_id: questionnaire.m_questions.first.id,
                              user_id: user_id,
                              answer_id: params[:answer])

    CompletedQuestionnaire.create(questionnaire_id: questionnaire.id,
                                  user_id: user_id)
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end
end
