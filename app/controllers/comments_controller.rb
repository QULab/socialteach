class CommentsController < ApplicationController

	before_action :set_comment, only:[:upvote, :downvote]

  def index
    @comments = Comment.hash_tree
  end

  def new
  	@comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
	if params[:comment][:parent_id].to_i > 0
		parent = Comment.find_by_id(params[:comment].delete(:parent_id))
		@comment = parent.children.build(comment_params)
	else
		@comment = Comment.new(comment_params)
	end

	if @comment.save
		flash[:success] = 'Your comment was successfully added!'
		redirect_to comments_path
	else
		render 'new'
	end
  end

  #upvote_from user
  #downvote_from user

  def upvote
  	@votingcomment.upvote_from current_user
  	redirect_to comments_path
  end

  def downvote
  	@votingcomment.downvote_from current_user
  	redirect_to comments_path
  end

  private

  def set_comment
  	@votingcomment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body, :author, :author_id, :course_id, :activity_id)
  end
end