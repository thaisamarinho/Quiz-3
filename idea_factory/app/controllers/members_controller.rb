class MembersController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find params[:idea_id]
    member = Member.new
    member.idea = idea
    member.user = current_user
    if member.save
      redirect_to idea_path(idea), notice: "Thanks for becoming a member!"
    else
      redirect_to idea_path(idea), alert: "Can't become a member again!"
    end
  end

  def destroy
    member = Member.find params[:id]
    member.destroy
    redirect_to :back, notice: "Membership removed!"
  end

end
