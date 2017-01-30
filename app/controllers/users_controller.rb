class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show # 追加
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #Railsで一時的なメッセージ（フラッシュメッセージ）を表示するためには
      #redirect_toやrenderの前に挿入する必要がある。
      flash[:success] = "Welcome to the Sample App!"
      # あらかじめroutes.rbで resources :users を設定していたので表記は
      # 下記のようになるが、redirect_to user_path(@user) と同様の動きをする。
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Updated Profile"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :location, :password,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end
