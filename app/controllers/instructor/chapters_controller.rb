class Instructor::ChaptersController < Instructor::BaseController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

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
    @ordered_chapters = Chapter.order(:name)

  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)

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
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to instructor_chapter_path(@chapter), notice: 'Chapter was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to instructor_chapters_path, notice: 'Chapter was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
        params.require(:chapter).permit(:name, :shortname, :description, :course_id, :tier)
    end
end
