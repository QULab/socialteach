class Graph::ChaptersController < ApplicationController
  def show
    id = params[:id]
    chapter = Chapter.find id
    duells = chapter.activities.where(content_type:ActivityDuell)
    result = duells.select do |act|
        act.content.master == false
        end
    tmp = chapter.activities.all - result
    @activities = tmp

    @edges = @activities.map do |activity|
      activity.successors.map do |succ|
        [activity, succ]
      end
    end
    @edges.flatten! 1
  end
end
