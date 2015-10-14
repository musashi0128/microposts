class FavoriteshipsController < ApplicationController
    before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite!(@micropost)
    @feed_item = @micropost
  end
  
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite!(@micropost)
    @feed_item = @micropost
  end
end

