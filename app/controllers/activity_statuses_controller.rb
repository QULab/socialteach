class ActivityStatusesController < ApplicationController
  before_action :set_activity_status, only: [:show, :edit, :update, :destroy]

  # GET /activity_statuses
  # GET /activity_statuses.json
  def index
    @activity_statuses = ActivityStatus.all
  end

  # GET /activity_statuses/1
  # GET /activity_statuses/1.json
  def show
  end

  # GET /activity_statuses/new
  def new
    @activity_status = ActivityStatus.new
  end

  # GET /activity_statuses/1/edit
  def edit
  end

  # POST /activity_statuses
  # POST /activity_statuses.json
  def create
    @activity_status = ActivityStatus.new(activity_status_params)

    respond_to do |format|
      if @activity_status.save
        check_to_add_points
        format.html { redirect_to @activity_status, notice: 'Activity status was successfully created.' }
        format.json { render :show, status: :created, location: @activity_status }
      else
        format.html { render :new }
        format.json { render json: @activity_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_statuses/1
  # PATCH/PUT /activity_statuses/1.json
  def update
    respond_to do |format|
      if @activity_status.update(activity_status_params)
        check_to_add_points
        format.html { redirect_to @activity_status, notice: 'Activity status was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_status }
      else
        format.html { render :edit }
        format.json { render json: @activity_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_statuses/1
  # DELETE /activity_statuses/1.json
  def destroy
    @activity_status.destroy
    respond_to do |format|
      format.html { redirect_to activity_statuses_url, notice: 'Activity status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_status
      @activity_status = ActivityStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_status_params
      params.require(:activity_status).permit(:is_completed, :status, :activity_id, :course_enrollment_id)
    end

    # Check if points to add and if correct
    def check_to_add_points
      if @activity_status.is_completed
        if @activity_status.status == 1
          level_user = @activity_status.course_enrollment.level.level
          level_activity = @activity_status.activity.level.level
          levelpoints_activity = @activity_status.activity.levelpoints
          levelpoints = @activity_status.course_enrollment.add_points((levelpoints_activity/level_user)*levelpoints_activity, category: "Levelpoints")
        end
        learningpoints = @activity_status.course_enrollment.user.add_points(1,category: "Learningpoints")
      end
    end
end
