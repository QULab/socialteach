class CommentsController < ApplicationController

	before_action :set_comment, only:[:upvote, :downvote]

  ##
  # Show hash tree of comments
  # NOT USED
  # GET comment
  def index
    @comments = Comment.where(course_id: params[:course_id]).hash_tree
  end

  ##
  # Show new comment not nested in other comments
  # GET courses/course_id/comments/new
  def new
  	@comment = Comment.new(parent_id: params[:parent_id], course_id: params[:course_id])
  	@course = Course.find(params[:course_id])
  end

  ##
  # Create new comment persistent in database
  def create
  	puts params
	if params[:comment][:parent_id].to_i > 0
		parent = Comment.find_by_id(params[:comment].delete(:parent_id))
		@comment = parent.children.build(comment_params)
	else
		@comment = Comment.new(comment_params)
	end

	if @comment.save
		current_user.add_points(1,category: "Socialpoints")
		flash[:success] = 'Your comment was successfully added!'
		redirect_to course_path(Course.find(params[:course_id]))
	else
		render 'new'
	end
  end

  #upvote_from user
  #downvote_from user

  ##
  # Upvote per user of comments
  def upvote
  	@votingcomment.upvote_from current_user
  	redirect_to course_path(params[:course_id])
  end

  ##
  # Downvote per user of comments
  def downvote
  	@votingcomment.downvote_from current_user
  	redirect_to course_path(params[:course_id])
  end

  private

  def set_comment
  	@votingcomment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body, :author, :author_id, :course_id, :activity_id)
  end
end