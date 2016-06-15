class CoursesController < BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :curriculum, :feedback]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  # Show different page enrolled user
  # TODO: add different view for instructor
  def show
    if user_signed_in?
      set_enrollment(current_user)
      # the enrollment could be nil, if user is not enrolled
      unless @enrollment.nil?
        render :show_enrolled
      end
    else
    render :show
    end
  end

  def index_enrolled
    authenticate_user!
    set_enrollments(current_user)

    unless @enrollments.empty?
      render :index_enrolled
    else
    render :index
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def curriculum
    authenticate_user!
    @active_chapter = Chapter.find_by_id(params[:chapter]) || @course.chapters.first
    set_enrollment(current_user)
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /activities/1/feedback
  def feedback
    questionnaire = @course.feedback.questionnaire
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
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description)
    end

    # There should be only one enrollment per user/course combination
    def set_enrollment(user)
      @enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", user.id, @course.id).first
    end

    # Get an array of all enrollments of the given user
    def set_enrollments(user)
      @enrollments = CourseEnrollment.where("user_id = ?", user.id).to_a
    end
end
