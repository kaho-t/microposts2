class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    @user.update(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを編集しました'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ編集に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    
    flash[:success] = '退会しました'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
