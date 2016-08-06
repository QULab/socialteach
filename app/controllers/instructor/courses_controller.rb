class Instructor::CoursesController < Instructor::BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  ##
  # Shows all courses created by the current user.
  def index
    @courses = current_user.get_created_courses
  end

  def show
  end

  def edit
    require_permission(@course)
  end

  ##
  # Creates a new course.
  def create
    @course = Course.new(course_params)


    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_instructor_course_path(@course), notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  ##
  # Shows the new page for courses.
  def new
    @course = Course.new
  end

  ##
  # Deletes a specific course.
  def destroy
    require_permission(@course)
    @course.destroy
    respond_to do |format|
      format.html { redirect_to instructor_courses_path, notice: 'Course was successfully destroyed.' }
    end
  end

  ##
  # Changes an existing course.
  def update
    require_permission(@course)
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to instructor_course_path(@course), notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
        params.require(:course).permit(:name, :description, :creator_id, :published)
    end
end
