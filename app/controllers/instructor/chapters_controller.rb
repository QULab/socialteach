class Instructor::ChaptersController < Instructor::BaseController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :predec, :tier]

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.all
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new

    @ordered_chapters = Chapter.order(:name)

  end

  # GET /chapters/1/edit
  def edit
    require_permission(@chapter.course)
    @ordered_chapters = Chapter.all
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)

    require_permission(@chapter.course)
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to instructor_chapter_path(@chapter), notice: 'Chapter was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    require_permission(@chapter.course)
    @ordered_chapters = Chapter.all
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to edit_instructor_course_path(@chapter.course), notice: 'Chapter was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    course = @chapter.course
    require_permission(course)
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to edit_instructor_course_path(course), notice: 'Chapter was successfully destroyed.' }
    end
  end

  respond_to :js
  def predec
    render partial: 'instructor/courses/chapter_predec', locals: {chapter: @chapter}
  end

  respond_to :js
  def tier
    render partial: 'instructor/courses/chapter_tier', locals: {chapter: @chapter}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
        params.require(:chapter).permit(:name, :shortname, :description, :course_id, :tier, :predecessor_ids => [])
    end
end
