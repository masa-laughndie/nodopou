class PostsController < ApplicationController

  before_action :logged_in_user, except: :show

  def create
    list_contents = current_user.lists.where("mylists.active IN (?)", true).pluck(:content)

    @post = current_user.posts.build
    @sentense = @post.insert_new_line(list_contents)
    @post.create_image_for_twitter(@sentense)
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
