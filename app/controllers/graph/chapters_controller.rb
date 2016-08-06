##
# Controls the export of Chapters in a special graph format (for visualization)
class Graph::ChaptersController < ApplicationController

  ##
  # Retrieves the data necessary to export a Chapter as graph:
  #
  # @activities - contains all activities of the course
  #
  # @edges - contains all connections between the activities (pred / succ)
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
