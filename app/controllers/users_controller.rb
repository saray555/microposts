class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]

  def show
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
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
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings List (フォローリスト)"
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers List (フォロワーリスト)"
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_path if @user != current_user
  end
end
