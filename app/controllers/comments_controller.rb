class CommentsController < ApplicationController
  def index
    @comments = Comment.where(course_id: params[:course_id]).hash_tree
  end

  def new
  	@comment = Comment.new(parent_id: params[:parent_id], course_id: params[:course_id])
  	@course = Course.find(params[:course_id])
  end

  def create
  	puts params
	if params[:comment][:parent_id].to_i > 0
		parent = Comment.find_by_id(params[:comment].delete(:parent_id))
		@comment = parent.children.build(comment_params)
	else
		@comment = Comment.new(comment_params)
	end

	if @comment.save
		flash[:success] = 'Your comment was successfully added!'
		redirect_to course_path(Course.find(params[:course_id]))
	else
		render 'new'
	end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :author, :author_id, :course_id, :activity_id)
  end
end