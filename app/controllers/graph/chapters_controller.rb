class Graph::ChaptersController < ApplicationController
  def show
    id = params[:id]
    chapter = Chapter.find id
    @activities = chapter.activities.where.not(content_type:ActivityDuell)

    @edges = @activities.map do |activity|
      activity.successors.map do |succ|
        [activity, succ]
      end
    end
    @edges.flatten! 1
  end
end
