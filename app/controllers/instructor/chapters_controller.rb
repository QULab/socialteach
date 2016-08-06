class Instructor::ChaptersController < Instructor::BaseController
  before_action :set_chapter, only: [:edit, :update, :destroy, :predec, :tier]

  ##
  # Shows the new page for chapters.
  # Expects a param for the :course_id
  # --
  # GET /chapters/new
  def new
    @chapter = Chapter.new(params.permit(:course_id))
  end

  # GET /chapters/1/edit
  def edit
    require_permission(@chapter.course)
  end

  ##
  # Creates a new chapter. Only the creator of the course may create new
  # chapters.
  # --
  # POST /chapters
  def create
    @chapter = Chapter.new(chapter_params)

    require_permission(@chapter.course)
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to edit_instructor_course_path(@chapter.course), notice: 'Chapter was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  ##
  # Changes an existing chapter.
  # --
  # PATCH/PUT /chapters/1
  def update
    require_permission(@chapter.course)
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to edit_instructor_course_path(@chapter.course), notice: 'Chapter was successfully updated.' }
      else
        format.html { render :edit}
      end
    end
  end

  ##
  # Deletes a specific chapter.
  # --
  # DELETE /chapters/1
  def destroy
    course = @chapter.course
    require_permission(course)
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to edit_instructor_course_path(course), notice: 'Chapter was successfully destroyed.' }
    end
  end

  ##
  # Renders the partial for editing the predecessors for a chapter.
  respond_to :js
  def predec
    render partial: 'instructor/courses/chapter_predec', locals: {chapter: @chapter}
  end

  ##
  # Renders the partial for editing the tier for a chapter.
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
