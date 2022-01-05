class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show] # ログインしていなければダメ
  before_action :set_user, :only => [:show, :destroy]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_url #削除に成功すればrootページに戻る
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
  end
  
  def set_user
     @user = User.find_by(:id => params[:id])
  end
end
