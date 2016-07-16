class ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :complete, :feedback, :result]


  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  def complete
      success_status = ActivityStatus.successfull

      enrollment = current_user.get_enrollment(@activity.course)

      if @activity.content.is_a?(ActivityExercise) || @activity.content.is_a?(ActivityAssessment)
        questionnaire = @activity.content.questionnaire
        user_id = current_user.id

	      # Completed Questionnaire and Answers
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

        # Chapter Status and Difficulty Fit
        activity_chapter = @activity.chapter

        # retrieve chapterStatus of chapter
        chapter_status = enrollment.chapter_statuses.find_by(chapter: activity_chapter)

        # returns a value according to the ruleset
        adaption_value = difficulty_adaption_ruleset(cquestionnaire.score)

        # assign calculated adaption value to chapterStatus
        old_adaption_value = chapter_status.difficultyFit
        new_adaption_value = old_adaption_value + adaption_value
        logger.debug "New difficulty adaption value: #{new_adaption_value}"
        chapter_status.difficultyFit = new_adaption_value
        chapter_status.save
      end

      enrollment.current_chapter = activity_chapter
      enrollment.save

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

    logger.debug "\nFeedback adjustment: #{feedback_processing(cquestionnaire)}\n"

    head :no_content
  end

  # GET /activities/1/result
  def result
    render 'result', completed_questionnaire: @activity.content.questionnaire.completed_questionnaires.where(user_id: current_user.id).last, container: @activity.content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def difficulty_adaption_ruleset(ratio)
      case ratio
      when 0.9..Float::INFINITY
        2
      when 0.6...0.9
        1
      when 0.3...0.6
        0
      when 0.1...0.3
        -1
      when 0...0.1
        -2
      end
    end

    def feedback_processing(cquestionnaire)
      difficulty_adaption = 0
      cquestion = cquestionnaire.completed_m_questions.first

      case cquestion.answers.first.text
      when 'Too Easy'
        1
      when 'Perfect Difficulty'
        0
      when 'Too Hard'
        -1
      end
    end

end
