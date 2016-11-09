class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new
    like.idea = idea
    like.user = current_user
    if like.save
      redirect_to idea_path(idea), notice: "Thanks for liking!"
    else
      redirect_to idea_path(idea), alert: "Can't like again!"
    end
  end

  def destroy
    like = Like.find params[:id]
    like.destroy
    redirect_to :back, notice: "Like removed!"
  end


end
