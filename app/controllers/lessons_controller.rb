class LessonsController < InheritedResources::Base

  private

    def lesson_params
      params.require(:lesson).permit(:name, :description, :lecture_id)
    end
end

