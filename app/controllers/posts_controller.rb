class PostsController < ApplicationController

  before_action :logged_in_user
  before_action :twitter_client, only: :create

  def create
    list_contents = current_user.lists.where("mylists.active IN (?)", true).pluck(:content)
    @post = current_user.posts.build
    @post.create_picture_for_twitter(list_contents)

    if @post.save
      twi_content = current_user.name + "さんのやらないことリスト\n\n便乗する→" +
                    "https://nodobotoke.herokuapp.com" + "\n\n#nodoby #nottodo"
      file = File.open(@post.picture.path)
      @twi_client.update_with_media(twi_content, file)
      # @twi_client.update(twi_client)
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
    @posts = current_user.posts
  end

  private

    def post_params
      params.require(:post).permit(:picture)
    end

    def twitter_client
      auth_token  = current_user.unlock_for(current_user.t_token, current_user.uid)
      auth_secret = current_user.unlock_for(current_user.t_secret, current_user.uid)

      @twi_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_KEY']
        config.consumer_secret     = ENV['TWITTER_SECRET']
        config.access_token        = auth_token
        config.access_token_secret = auth_secret
      end
    end
end
