class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true

  def create_image_for_twitter(texts)
    img = MiniMagick::Image.open("#{Rails.root}/public/images/frame.png")
    img.combine_options do |i|
      # i.gravity "center"
      i.encoding "UTF-8"
      i.font "Arial"
      i.font "c:/windows/fonts/fujipop.ttc"
      i.pointsize 25
      i.fill "#000000"
      j = 150
      texts.each do |ttext|
        ttext = ttext
        i.draw "text 130,#{j} '#{ttext}'"
        j += 25
      end
    end

    img.write "#{Rails.root}/public/images/temp.png"
    file = File.open("#{Rails.root}/public/images/temp.png")
    self.picture = ActionDispatch::Http::UploadedFile.new(tempfile: file,
                                                          filename: File.basename(file),
                                                          content_type: "image/png")
  end



end
