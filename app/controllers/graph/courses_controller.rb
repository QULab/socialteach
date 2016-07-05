class Graph::CoursesController < ApplicationController
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
