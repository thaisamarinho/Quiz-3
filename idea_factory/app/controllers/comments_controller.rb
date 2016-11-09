class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @idea = Idea.find params[:idea_id]
    @comment = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user
    if @comment.save
      redirect_to idea_path(@idea), notice: 'Comment Created!'
    else
      render 'ideas/show'
    end
  end

  def destroy
    @comment = Comment.find params[:id]
      idea = @comment.idea
      if (can? :delete, @comment)
        @comment.destroy
        redirect_to idea_path(idea), notice: "Comment deleted!"
      else
        redirect_to root_path, alert: "Access Denied!"
      end
  end

  private

  def authorize_access
    unless can? :delete, @comment
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  def comment_params
    comment_params = params.require(:comment).permit(:body)
  end

end
