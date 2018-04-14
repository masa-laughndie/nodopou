module UsersHelper

  def image_url(user)
    if user.image?
      "#{user.image}"
    else
      "/images/grey.gif"
    end
  end
end
