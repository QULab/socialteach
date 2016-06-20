class ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :complete, :feedback]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    unless current_user.completed?(@activity)
      if @activity.content.is_a?(ActivityExcercise) || @activity.content.is_a?(ActivityAssessment)
        questionnaire = @activity.content.questionnaire
        user_id = current_user.id

        questionnaire.m_questions.each_with_index do |question, i|
          CompletedMQuestion.create(m_question_id: question.id,
                                    user_id: user_id,
                                    answer_id: params[:question][i.to_s.to_sym][:answer_id])
        end
        CompletedQuestionnaire.create(questionnaire_id: questionnaire.id, user_id: user_id)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :levelpoints, :chapter, :question)
    end
end
