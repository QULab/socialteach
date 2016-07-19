class Instructor::CourseBadgesController < Instructor::BaseController
  before_action :set_course_badge, only: [:show, :edit, :update, :destroy]

  # GET /course_badges
  # GET /course_badges.json
  def index
    @course_badges = CourseBadge.where(course_id: params[:course_id])
  end

  # GET /course_badges/1
  # GET /course_badges/1.json
  def show
  end

  # GET /course_badges/new
  def new
    @course_badge = Course.find(params[:course_id]).course_badges.build
    @path = [:instructor, @course_badge.course, @course_badge]
    #puts @path
  end

  # GET /course_badges/1/edit
  def edit
    @path = [:instructor, @course_badge]
  end

  # POST /course_badges
  # POST /course_badges.json
  def create
    require_permission(Course.find(params[:course_id]))
    @course_badge = Course.find(params[:course_id]).course_badges.build(course_badge_params)
    puts params
    @path = [:instructor, @course_badge.course, @course_badge]
    respond_to do |format|
      if @course_badge.save
        format.html { redirect_to instructor_course_course_badges_path(@course_badge.course_id), notice: 'Course badge was successfully created.' }
        format.json { render :show, status: :created, location: @course_badge }
      else
        format.html { render :new }
        format.json { render json: @course_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_badges/1
  # PATCH/PUT /course_badges/1.json
  def update
    require_permission(@course_badge.course)
    @path = [:instructor, @course_badge]
    respond_to do |format|
      if @course_badge.update(course_badge_params)
        format.html { redirect_to instructor_course_course_badges_path(@course_badge.course_id), notice: 'Course badge was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_badge }
      else
        format.html { render :edit }
        format.json { render json: @course_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_badges/1
  # DELETE /course_badges/1.json
  def destroy
    require_permission(@course_badge.course)
    course_id = @course_badge.course_id
    @course_badge.destroy
    respond_to do |format|
      format.html { redirect_to instructor_course_course_badges_path(course_id), notice: 'Course badge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_badge
      @course_badge = CourseBadge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_badge_params
      params.require(:course_badge).permit(:badge, :description, :course_id, unlock_course_badges_attributes: [:activity])
    end
end
