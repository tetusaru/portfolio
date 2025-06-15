class FavoritesController < ApplicationController
  before_action :require_login

  def create
    sauna = SaunaFacility.find(params[:sauna_facility_id])
    current_user.favorites.find_or_create_by(sauna_facility: sauna)
    redirect_to request.referer || mypage_user_path(current_user), notice: "お気に入りに追加しました"
  end
  
  def destroy
    sauna = SaunaFacility.find(params[:sauna_facility_id])
    current_user.favorites.where(sauna_facility: sauna).destroy_all
    redirect_to request.referer || mypage_user_path(current_user), notice: "お気に入りを解除しました"
  end
end
