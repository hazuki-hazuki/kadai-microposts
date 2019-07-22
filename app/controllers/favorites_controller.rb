class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @favorites = Favorite.order(id: :desc).page(params[:page]).per(25)
  end

  def show
  end
  
  def new
  end

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = '投稿をお気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = '投稿をお気に入りから削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
