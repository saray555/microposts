class UsersController < ApplicationController
  def show # 追加
   @user = User.find(params[:id])
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
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
