class ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :complete, :feedback, :result]


  # GET /activities/1
  # GET /activities/1.json
  def show
    # check enrollment
    # this should also redirect if the course is not published (because then there can be no enrollment)
    unless current_user.is_enrolled?(@activity.course)
      redirect_to courses_path, notice: 'You are not enrolled in this course'
    end
  end

  def complete
    # unless current_user.completed?(@activity)

      success_status = ActivityStatus.successfull

      if @activity.content.is_a?(ActivityExercise) || @activity.content.is_a?(ActivityAssessment)
        questionnaire = @activity.content.questionnaire
        user_id = current_user.id

        cquestionnaire = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user_id)

        questionnaire.m_questions.each_with_index do |question, i|
          cquestion = CompletedMQuestion.create(m_question_id: question.id,
                                    completed_questionnaire_id: cquestionnaire.id,
                                    user_id: user_id)

          answers = params[:question][i.to_s.to_sym][:answers]
          unless answers.nil?
            answers.each do |answer|
              cquestion.answers << Answer.find(answer[1][:answer_id])
            end
          end

        end
        success_status = ActivityStatus.failed unless cquestionnaire.passed? || @activity.content.is_a?(ActivityAssessment)
      end
      enrollment = current_user.get_enrollment(@activity.course)
      status = ActivityStatus.new(is_completed: true, course_enrollment: enrollment, activity: @activity, status: success_status)
      status.save
      if @activity.content.is_a?(ActivityExercise) || @activity.content.is_a?(ActivityAssessment)
        redirect_to activity_result_path(@activity) , notice: 'Congratulations, you finished this Activity!'
      else
        redirect_to curriculum_course_path(@activity.course) , notice: 'Congratulations, you finished this Activity!'
      end
    # else
      # redirect_to curriculum_course_path(@activity.course) , notice: 'You already finished this activity before!'
    # end
  end

  # POST /activities/1/feedback
  def feedback
    questionnaire = @activity.feedback.questionnaire
    user_id = current_user.id
    cquestionnaire = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id,
                                  user_id: user_id)

    CompletedMQuestion.create!(m_question_id: questionnaire.m_questions.first.id,
                              completed_questionnaire_id: cquestionnaire.id,
                              user_id: user_id).answers << Answer.find(params[:answer])

    head :no_content
  end

  # GET /activities/1/result
  def result
    # check enrollment
    unless current_user.is_enrolled?(@activity.course)
      redirect_to courses_path, notice: 'You are not enrolled in this course'
    end
    # check if user already completed this activity
    result = @activity.content.questionnaire.completed_questionnaires.where(user_id: current_user.id).last
    if result.present?
      render 'result', completed_questionnaire: result, container: @activity.content
    else
      redirect_to curriculum_course_path(@activity.course), notice: "You have not finished this activity yet!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end
end
