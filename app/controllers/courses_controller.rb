class CoursesController < BaseController
  before_action :set_course, only: [:show, :curriculum, :feedback]

  add_breadcrumb "Home", :root_path

  ##
  # Shows all courses that are published.
  # --
  # GET /courses
  def index
    add_breadcrumb "Courses", courses_path()
    @courses = Course.all_published_courses
  end

  ##
  # Show one specific course if it is published.
  # --
  # GET /courses/1
  def show
    @duell = ActivityDuell.all.where(enemy_id: current_user.id)
    # get all the duells that the current user was challenged to
    if @course.published
      render :show
    else
      redirect_to courses_path
    end
  end

  ##
  # Show the index page for enrollmets:
  # Shows the current user all courses where he is enrolled. Redirects to
  # course#index if there are no enrollments for this user.
  # --
  # GET /my_courses
  def index_enrolled
    authenticate_user!
    set_enrollments(current_user)

    unless @enrollments.empty?
      add_breadcrumb "MyCourses", my_courses_path()
      render :index_enrolled
    else
      @courses = Course.all
      redirect_to courses_path, notice: 'You are not yet enrolled in any Courses. Choose a course to start learning!'
    end
  end

  ##
  # Shows the enrolled user an overview over the course content of one specific
  # course.
  # --
  # GET /courses/1/curriculum
  def curriculum
    authenticate_user!
    # check for enrollment
    unless current_user.is_enrolled?(@course)
      redirect_to courses_path, notice: 'You are not enrolled in this course.'
    end

    set_enrollment(current_user)
    current_chapter = Chapter.find_by_id(@enrollment[:current_chapter_id])
    @active_chapter = Chapter.find_by_id(params[:chapter]) || current_chapter || @course.chapters.first
  end

  ##
  # Posts the users feedback to a course. Creates a new completed questionnarie.
  # --
  # POST /courses/1/feedback
  def feedback
    questionnaire = @course.feedback.questionnaire
    user_id = current_user.id
    cquestionnaire = CompletedQuestionnaire.create(questionnaire_id: questionnaire.id,
                                  user_id: user_id)

    CompletedMQuestion.create!(m_question_id: questionnaire.m_questions.first.id,
                              completed_questionnaire_id: cquestionnaire.id,
                              user_id: user_id).answers << Answer.find(params[:answer])

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
