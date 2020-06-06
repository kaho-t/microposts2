class FavoritesController < ApplicationController
  def create
    thepost = Micropost.find(params[:micropost_id])
    current_user.like(thepost)
    flash[:success] = "お気に入りに追加しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    thepost = Micropost.find(params[:micropost_id])
    current_user.unlike(thepost)
    flash[:success] = "お気に入り解除しました"
    redirect_back(fallback_location: root_path)
  end
end
