class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [ :destroy ]
  before_action :authorize_post_deletion, only: [ :destroy ]

  def create
    mysauna = current_user.mysauna

    if mysauna.last_posted_at.present? &&
       mysauna.updated_at.to_i <= mysauna.last_posted_at.to_i
      redirect_to mypage_user_path(current_user), alert: "内容が更新されていないため、再投稿はできません。"
      return
    end

    @post = current_user.posts.build(
      mysauna: mysauna,
      sauna_name: mysauna.sauna_name,
      comment: mysauna.comment
    )

    if mysauna.image.attached?
      @post.image.attach(mysauna.image.blob)
    end

    if @post.save
      mysauna.update(last_posted_at: Time.current)
      redirect_to posts_path, notice: "掲示板に投稿しました！"
    else
      redirect_to mypage_user_path(current_user), alert: "投稿に失敗しました。"
    end
  end

  def index
    @posts = Post.includes(:user, :image_attachment, mysauna: { image_attachment: :blob }).order(created_at: :desc)
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  def show
    @post = Post.includes(:user).find(params[:id])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post_deletion
    redirect_to posts_path, alert: "他人の投稿は削除できません" unless @post.user == current_user
  end
end
