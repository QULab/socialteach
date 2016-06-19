class Instructor::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_instructor_access

  def verify_instructor_access
    unless current_user.is_instructor
      redirect_to root_path
    end
  end
end
