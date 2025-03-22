class MysaunasController < ApplicationController
  before_action :set_mysauna, only: [ :edit, :update, :destroy ]
  before_action :require_login

  def new
    # ユーザーがすでにMysaunaを登録していれば編集画面にリダイレクト
    if current_user.mysauna
      redirect_to edit_mysauna_path(current_user.mysauna)
    else
      @mysauna = current_user.build_mysauna
    end
  end

  def create
    @mysauna = current_user.build_mysauna(mysauna_params)
    if @mysauna.save
      flash[:notice] = "Mysaunaを登録しました"
      redirect_to mypage_user_path(current_user)
    else
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @mysauna.update(mysauna_params)
      flash[:notice] = "Mysaunaを更新しました"
      redirect_to mypage_user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mysauna.destroy
    flash[:notice] = "Mysaunaを削除しました"
    redirect_to mypage_user_path(current_user)
  end

  def show_share
    @mysauna = Mysauna.find(params[:id])
    render layout: "ogp"
  end

  private

  def set_mysauna
    @mysauna = current_user.mysauna
    if @mysauna.nil? || @mysauna.id.to_s != params[:id]
      redirect_to root_path, alert: "不正なアクセスです" and return
    end
  end

  def mysauna_params
    params.require(:mysauna).permit(:sauna_name, :comment, :image)
  end
end
