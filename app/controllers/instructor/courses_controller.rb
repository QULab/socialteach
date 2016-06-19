class Instructor::CoursesController < Instructor::BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = current_user.get_created_courses
  end

  def show
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to instructor_course_path(@course), notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def new
    @course = Course.new
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to instructor_courses_path, notice: 'Course was successfully destroyed.' }
    end
  end

  def update
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
end
