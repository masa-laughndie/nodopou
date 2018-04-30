module UsersHelper

  def image_url(user)
    if user.image?
      "#{user.image}"
    else
      "/images/grey.gif"
    end
  end

  def time_array
    ary = []
    24.times do |n|
      ary << ["#{n}時", n]
    end
    ary
  end

end
