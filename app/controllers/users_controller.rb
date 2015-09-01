class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
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
  def update
    if @user.update(user_params)
      # 保存に成功した場合はユーザーページへリダイレクト
      redirect_to edit_user_path , notice: 'ユーザー情報を編集しました'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  #課題追加場所ここまで
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
