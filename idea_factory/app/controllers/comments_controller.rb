class CommentsController < ApplicationController
  before_action :find_comment, only: :destroy
  before_action :authenticate_user
  before_action :authorize_access, only: :destroy


  def create
    @idea = Idea.find params[:idea_id]
    @comment = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user
    # byebug
    if @comment.save
      redirect_to idea_path(@idea), notice: 'Comment Created!'
    else
      flash.now[:alert] = 'Unable to save your comments, please see errors below'
      render 'ideas/show'
    end
  end

  def destroy
      idea = @comment.idea
      if @comment.destroy
        redirect_to idea_path(idea), notice: "Comment deleted!"
      else
        redirect_to root_path, alert: "Access Denied!"
      end
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end

  def authorize_access
    unless can? :delete, @comment
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  def comment_params
    comment_params = params.require(:comment).permit(:body)
  end

end
