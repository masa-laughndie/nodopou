class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: { message: "ユーザーを特定できません" }
  validates :picture, presence: { message: "画像がありません" }


  def connect_and_insert_new_line(text_ary, char_num)

    sentense = ""

    text_ary.each do |text|
      text = text.gsub(/\r\n|\r|\n/," ")
      line = (text.length / char_num) + ((text.length % char_num > 0) ? 1 : 0)

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

  def create_picture_for_twitter(contents)
    contents_num = contents.length
    char_sum = contents.sum.length
    char_ave = char_sum / contents_num

    # 要検証
    if contents_num > 8 || char_sum > 123
      font_size = 17
      line_char_num = 25
    else
      font_size = 21
      line_char_num = 20
    end

    sentense = self.connect_and_insert_new_line(contents, line_char_num)

    img = MiniMagick::Image.open("#{Rails.root}/public/images/twitter_frame.png")
    img.combine_options do |i|
      i.gravity "West"
      i.font "fonts/GenJyuuGothic-Heavy.ttf"
      i.pointsize font_size
      i.fill "black"
      i.draw "text 67,0 '#{sentense}'"
    end

    # img.write "#{Rails.root}/public/images/temp.png"
    # file = File.open("#{Rails.root}/public/images/temp.png")
    file = img.tempfile
    self.picture = ActionDispatch::Http::UploadedFile.new(tempfile: file,
                                                          filename: File.basename(file),
                                                          content_type: "image/png")
  end

end
