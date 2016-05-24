class LecturesController < BaseController

  private

    def lecture_params
      params.require(:lecture).permit(:name, :description, :course_id)
    end
end
