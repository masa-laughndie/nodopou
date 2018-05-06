class PostsController < ApplicationController

  before_action :logged_in_user, except: :show

  def create
    list_contents = current_user.lists.pluck(:content).take(5)
    @text = "".encode('UTF-8')
    list_contents.each do |string|
      @text << string.encode('UTF-8') + "\n".encode('UTF-8')
    end

    @post = current_user.posts.build
    @post.create_image_for_twitter(list_contents)
    if @post.save
      flash[:success] = "ポストの作成に成功しました！"
      redirect_to current_user
    else
      flash[:danger] = "ポストの作成に失敗しました"
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
    @post = current_user.posts.first
  end

  private

    def post_params
      params.require(:post).permit(:picture)
    end
end