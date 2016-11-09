class IdeasController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]
  before_action :find_idea, only: [:edit, :update, :destroy, :show]
  before_action :authorize_access, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
     if @idea.save
       flash[:notice] = 'Idea Created!'
       redirect_to idea_path(@idea)
     else
       flash.now[:alert] = 'Please see errors below'
       render :new
     end
  end

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @like = @idea.likes.find_by(user: current_user)
    @member = @idea.members.find_by(user: current_user)
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path, notice: 'Idea Deleted'
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :body)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_access
    unless can? :manage, @idea
      redirect_to root_path, alert: 'Access Denied'
    end
  end

end
