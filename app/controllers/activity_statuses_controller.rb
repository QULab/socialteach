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
      params.require(:activity_status).permit(:is_completed, :Status, :Activity, :Course_enrollment)
    end
end
