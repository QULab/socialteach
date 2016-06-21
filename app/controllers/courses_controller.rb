class CoursesController < BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :curriculum, :feedback]

  before_filter :require_permission, only: [:edit, :update, :destroy]

  def require_permission
    if current_user.id != Course.find(params[:id]).creator_id
      flash[:notice] = "You are not allowed to access to page!"
      redirect_to root_path
    end
  end
    
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    render :show
  end

  def index_enrolled
    authenticate_user!
    set_enrollments(current_user)

    unless @enrollments.empty?
      render :index_enrolled
    else
      @courses = Course.all
      redirect_to courses_path, notice: 'You are not yet enrolled in any Courses. Choose a course to start learning!'
    end
  end

  def curriculum
    authenticate_user!
    @active_chapter = Chapter.find_by_id(params[:chapter]) || @course.chapters.first
    set_enrollment(current_user)
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
        params.require(:course).permit(:name, :description, :creator_id)
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
