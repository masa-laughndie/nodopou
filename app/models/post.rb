class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true

  def create_image_for_twitter(texts)
    img = MiniMagick::Image.open("#{Rails.root}/public/images/frame.png")
    img.combine_options do |i|
      i.gravity "center"
      i.font "fonts/Jiyucho.ttf"
      i.pointsize 25
      i.fill "black"
      i.draw "text 0,0 '#{texts}'"
    end

    img.write "#{Rails.root}/public/images/temp.png"
    file = File.open("#{Rails.root}/public/images/temp.png")
    self.picture = ActionDispatch::Http::UploadedFile.new(tempfile: file,
                                                          filename: File.basename(file),
                                                          content_type: "image/png")
  end



end
