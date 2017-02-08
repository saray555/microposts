class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :index]
    
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]) 
      render 'static_pages/home'
    end
  end
  
  #def index
  #  # 1ページあたりの表示数を指定する場合 [.per(1)]をつける
  #  @microposts = Micropost.page(params[:page]).per(2)
  #end  
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end