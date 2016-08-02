class Instructor::ActivitiesController < Instructor::BaseController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :predec, :tier]

  ##
  # Posts the current content text of a lecture. Returns the markdown rendered
  # version of that text.
  # --
  # POST /activities/markwodn
  def markdown
    text = params[:text] || ''

    renderer = Redcarpet::Render::HTML.new(escape_html: true, safe_links_only: true)
    markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true)
    render text: markdown.render(text)
  end

  ##
  # Show one specific activity.
  # --
  # GET /activities/1
  def show
  end

  ##
  # Shows the new page for activities.
  # Expects a param for the :chapter_id
  # Expects a param :content_type for the type of content
  # Content can be one of the following: lecture, exercise, assessment
  # --
  # GET /activities/new
  def new
    chapter = Chapter.find(params[:chapter_id])
    @activity = chapter.activities.new

    if params[:content_type] == "lecture"
      @activity.content = ActivityLecture.new
    elsif params[:content_type] == "exercise"
      @activity.content = ActivityExercise.new
      @activity.content.questionnaire = Questionnaire.new(qu_container: @activity.content)
      2.times do
        question = @activity.content.questionnaire.m_questions.build
        3.times { question.answers.build }
      end
    elsif params[:content_type] == "assessment"
      @activity.content = ActivityAssessment.new
      @activity.content.questionnaire = Questionnaire.new(qu_container: @activity.content)
      2.times do
        question = @activity.content.questionnaire.m_questions.build
        3.times { question.answers.build }
      end
    elsif params[:content_type] == "duell"
      @activity.content = ActivityDuell.new
      @activity.content.questionnaire = Questionnaire.new(qu_container: @activity.content)
      2.times do
        question = @activity.content.questionnaire.m_questions.build
        3.times { question.answers.build }
      end
    else
      raise "Invalid Type Parameter"
    end
  end

  # GET /activities/1/edit
  def edit
    require_permission(@activity.course)
  end

  ##
  # Creates a new activity if the content type is ActivityExercise or
  # ActivityAssessment a questionnaire is created as well. Only the creator of
  # the course may create new activities.
  # --
  # POST /activities
  def create
    @activity = Activity.new(activity_params)
    require_permission(@activity.course)

    if @activity.content_type == "ActivityLecture"
      @activity.content = ActivityLecture.new(content_params)
    elsif @activity.content_type == "ActivityExercise"
      @activity.content = ActivityExercise.new(content_params)
      @activity.content.questionnaire = Questionnaire.new(questionnaire_params)
    elsif @activity.content_type == "ActivityAssessment"
      @activity.content = ActivityAssessment.new(content_params)
      @activity.content.questionnaire = Questionnaire.new(questionnaire_params)
    elsif @activity.content_type == "ActivityDuell"
      @activity.content = ActivityDuell.new(content_params)
      @activity.content.questionnaire = Questionnaire.new(questionnaire_params)
      @activity.content.master = true
    else
      raise "Invalid Type Parameter"
    end

    respond_to do |format|
      if @activity.save
        format.html { redirect_to instructor_activity_path(@activity), notice: 'Activity was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  ##
  # Changes an existing Activity.
  # --
  # PATCH/PUT /activities/1
  def update
    require_permission(@activity.course)
    respond_to do |format|
      @activity.assign_attributes(activity_params)
      @activity.content.assign_attributes(content_params) if params[:activity].has_key?(:content_attributes)
      if @activity.save
        format.html { redirect_to edit_instructor_chapter_path(@activity.chapter), notice: 'Activity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  ##
  # Deletes a specific activity.
  # --
  # DELETE /activities/1
  def destroy
    require_permission(@activity.course)
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to edit_instructor_chapter_path(@activity.chapter), notice: 'Activity was successfully destroyed.' }
    end
  end

  ##
  # Renders the partial for editing the predecessors for an activity.
  respond_to :js
  def predec
    render partial: 'instructor/chapters/activity_predec', locals: {activity: @activity}
  end

  ##
  # Renders the partial for editing the tier for an activity.
  respond_to :js
  def tier
    render partial: 'instructor/chapters/activity_tier', locals: {activity: @activity}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      #params.require(:activity).permit!
      params.require(:activity).permit(:name, :levelpoints, :shortname, :tier, :chapter_id, :question, :content_type, :difficulty,:level_id, :predecessor_ids => [])
    end

    def content_params
      #params.require(:activity).require(:content_attributes).permit(:text)
      params.require(:activity).require(:content_attributes).permit!
    end

    def questionnaire_params
    #  params.require(:activity).require(:content_attributes).require(:questionnaire_attributes).permit(m_questions: [])
    params.require(:activity).require(:content_attributes).require(:questionnaire_attributes).permit!
    end
end
