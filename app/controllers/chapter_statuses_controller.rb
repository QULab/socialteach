class ChapterStatusesController < ApplicationController
  before_action :set_chapter_status, only: [:show, :edit, :update, :destroy]

  # GET /chapter_statuses
  # GET /chapter_statuses.json
  def index
    @chapter_statuses = ChapterStatus.all
  end

  # GET /chapter_statuses/1
  # GET /chapter_statuses/1.json
  def show
  end

  # GET /chapter_statuses/new
  def new
    @chapter_status = ChapterStatus.new
  end

  # GET /chapter_statuses/1/edit
  def edit
  end

  # POST /chapter_statuses
  # POST /chapter_statuses.json
  def create
    @chapter_status = ChapterStatus.new(chapter_status_params)

    respond_to do |format|
      if @chapter_status.save
        format.html { redirect_to @chapter_status, notice: 'Chapter status was successfully created.' }
        format.json { render :show, status: :created, location: @chapter_status }
      else
        format.html { render :new }
        format.json { render json: @chapter_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapter_statuses/1
  # PATCH/PUT /chapter_statuses/1.json
  def update
    respond_to do |format|
      if @chapter_status.update(chapter_status_params)
        format.html { redirect_to @chapter_status, notice: 'Chapter status was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter_status }
      else
        format.html { render :edit }
        format.json { render json: @chapter_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapter_statuses/1
  # DELETE /chapter_statuses/1.json
  def destroy
    @chapter_status.destroy
    respond_to do |format|
      format.html { redirect_to chapter_statuses_url, notice: 'Chapter status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter_status
      @chapter_status = ChapterStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_status_params
      params.require(:chapter_status).permit(:skip, :course_enrollment_id)
    end
end
