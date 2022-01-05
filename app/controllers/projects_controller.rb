class ProjectsController < ApplicationController
  before_action :require_user_logged_in, only: [:new] # ログインしていなければダメ
  before_action :correct_user, only: [:edit, :update, :destroy] # 自分しかダメ
  # before_action :project_find, only [:show]
  
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
    @user = User.all
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = 'プロジェクトを作成しました'
      redirect_to root_url
    else
      @pagy, @projects = pagy(current_user.projects.order(id: :desc))
      flash.now[:danger] = 'プロジェクト作成に失敗しました'
      render :new
    end
  end

  def destroy
    @project.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :explanation)
  end
  
  def correct_user # ログインしている人のみ
    @project = current_user.projects.find_by(id: params[:id])
    unless @project
      redirect_to root_url
    end
  end
end
