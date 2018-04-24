class List < ApplicationRecord

  belongs_to :user


  validates :user_id,  presence: { message: "ユーザーが特定できません" }
  validates :content,  presence: { message: "内容を入力してください" },
                       length:   { maximum: 100,
                                   message: "内容は100文字まで入力できます" }

  def toggle!(attribute)
    update(attribute.to_sym => !self.send("#{attribute}"))
  end

  def search(keyword)
    if keyword
      kerword_arys = keyword.split(/[\s　]+/)
      condition = where(["lower(content) LIKE (?)", "%#{keyword_arys[0]}%".downcase])
      for i in 1..(keyword_arys.length - 1) do
        condition = condition.where(["lower(content) LIKE (?)", "%#{keyword_arys[i]}%".downcase])
      end
      condition
    else
      all
    end
  end

end
