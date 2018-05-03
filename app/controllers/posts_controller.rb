class PostsController < ApplicationController

  before_action :logged_in_user, except: :show

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "ポストの作成に成功しました！"
      redirect_to current_user
    end
  end

  def destroy
    @post = Post.find(id: params[:id])
    @post.destroy
    flash[:success] = "ポストの削除が完了しました"
    redirect_to current_user
  end

  def show
  end

  private

    def post_params
      params.require(:post).permit(:picture)
    end
end
