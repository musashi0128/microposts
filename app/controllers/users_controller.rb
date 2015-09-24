class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :following, :followers]
  
  def show
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  #課題追加場所
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はユーザーページへリダイレクト
      redirect_to @user , notice: 'ユーザー情報を編集しました'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @title = "Following"
    @user  = User.find(params[:id])
    @following_users = @user.following_users
  end
  
  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @follower_users = @user.follower_users
  end
  
  def favorite
    @user  = User.find(params[:id])
    @feed_items = @user.favorited_posts.page(params[:page])
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  #課題追加場所ここまで
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :area)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
