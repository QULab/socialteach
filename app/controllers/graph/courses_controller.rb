##
# Controls the export of Courses in a special graph format (for visualization)
class Graph::CoursesController < ApplicationController

  ##
  # Retrieves the data necessary to export a course as graph:
  #
  # @chapters - contains all chapters of the course
  #
  # @edges - contains all connections between the chapters (pred / succ)
  def show
    id = params[:id]
    course = Course.find id
    @chapters = course.chapters

    @edges = @chapters.map do |chapter|
      chapter.successors.map do |succ|
        [chapter, succ]
      end
    end
    @edges.flatten! 1
  end
end
