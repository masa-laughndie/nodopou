class PostsController < ApplicationController

  before_action :logged_in_user
  before_action :check_post, only: [:show, :tweet]
  before_action :twitter_client, only: :tweet

  def create
    list_contents = current_user.lists.where("mylists.active IN (?)", true).pluck(:content)
    @post = current_user.posts.build
    @post.create_picture_for_twitter(list_contents)

    if @post.save
      redirect_to preview_path
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
  end

  def tweet
    if params[:content].length > 100
      flash[:danger] = "ツイート内容の文字数制限を超えています！"
      redirect_to preview_path
    else
      twi_content = params[:content] +
                    "\n\n#nodopou #nottodo\n" +
                    mylists_user_url(current_user)
=begin
      if Rails.env.development? || Rails.env.test?
        file = open(@post.picture.path)
      elsif Rails.env.production?
        file = open(@post.picture.url)
      end
      @twi_client.update_with_media(twi_content, file)
=end
      @twi_client.update(twi_content)
      flash[:success] = "ツイートに成功しました！"
      redirect_to current_user
    end
  end

  private

    def post_params
      params.require(:post).permit(:picture)
    end

    def twitter_client
      auth_token  = current_user.unlock_for(current_user.t_token, current_user.uid)
      auth_secret = current_user.unlock_for(current_user.t_secret, current_user.uid)

      if Rails.env.production?
        con_key = ENV['TWITTER_KEY']
        con_sec = ENV['TWITTER_SECRET']
      else
        con_key = ENV['TWITTER_KEY_DEV']
        con_sec = ENV['TWITTER_SECRET_DEV']
      end

      @twi_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = con_key
        config.consumer_secret     = con_sec
        config.access_token        = auth_token
        config.access_token_secret = auth_secret
      end
    end

    def check_post
      @post = current_user.posts.last
      if @post.nil?
        flash[:danger] = "ツイート可能な画像はありません。"
        redirect_to current_user
      end
    end
end
