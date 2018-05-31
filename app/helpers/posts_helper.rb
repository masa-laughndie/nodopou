module PostsHelper

  def picture_url(post)
    if post.picture?
      "#{post.picture}"
    else
      "/images/grey.gif"
    end
  end

end
