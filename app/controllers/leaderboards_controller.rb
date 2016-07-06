class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: [:show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Course", :course_path

  # GET /leaderboards
  # GET /leaderboards.json
  def index
    # @leaderboards = Leaderboard.all
  end

  # GET /leaderboards/1
  # GET /leaderboards/1.json
  def show
    add_breadcrumb "Leaderboard", leaderboard_path()
    @course = Course.find(params[:id])
  end

=begin
  # GET /leaderboards/new
  def new
    @leaderboard = Leaderboard.new
  end

  # GET /leaderboards/1/edit
  def edit
  end

  # POST /leaderboards
  # POST /leaderboards.json
  def create
    @leaderboard = Leaderboard.new(leaderboard_params)

    respond_to do |format|
      if @leaderboard.save
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully created.' }
        format.json { render :show, status: :created, location: @leaderboard }
      else
        format.html { render :new }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaderboards/1
  # PATCH/PUT /leaderboards/1.json
  def update
    respond_to do |format|
      if @leaderboard.update(leaderboard_params)
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @leaderboard }
      else
        format.html { render :edit }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaderboards/1
  # DELETE /leaderboards/1.json
  def destroy
    @leaderboard.destroy
    respond_to do |format|
      format.html { redirect_to leaderboards_url, notice: 'Leaderboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard

      if params[:today]
        @leaderboard = Merit::Score.top_scored_enrolled(id: params[:id].to_i, since_date: 1.day.ago)
      elsif params[:week]
        @leaderboard = Merit::Score.top_scored_enrolled(id: params[:id].to_i, since_date: 1.week.ago)
      elsif params[:month]
        @leaderboard = Merit::Score.top_scored_enrolled(id: params[:id].to_i, since_date: 1.month.ago)
      else
        @leaderboard = Merit::Score.top_scored_enrolled(id: params[:id].to_i)
      end
        
        
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leaderboard_params
      params.fetch(:leaderboard, {})
    end
end
