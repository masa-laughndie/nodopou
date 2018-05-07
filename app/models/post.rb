class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true

  def insert_new_line(text_ary)

    sentense = ""
    char_num = 20

    text_ary.each do |text|
      text = text.gsub(/\r\n|\r|\n/," ")
      line = (text.length / char_num) + 1

      sentense += "・"

      line.times do |i|
        start_num = i * char_num
        sentense += text.slice(start_num, char_num)
        if i != line - 1
          sentense += "\n　"
        else
          sentense += "\n"
        end
      end
    end
    sentense
  end

  def create_image_for_twitter(sentense)
    img = MiniMagick::Image.open("#{Rails.root}/public/images/frame.png")
    img.combine_options do |i|
      i.gravity "West"
      i.font "fonts/Jiyucho.ttf"
      i.pointsize 25
      i.fill "black"
      i.draw "text 80,0 '#{sentense}'"
    end

    # img.write "#{Rails.root}/public/images/temp.png"
    # file = File.open("#{Rails.root}/public/images/temp.png")
    file = img.tempfile
    self.picture = ActionDispatch::Http::UploadedFile.new(tempfile: file,
                                                          filename: File.basename(file),
                                                          content_type: "image/png")
  end

end
