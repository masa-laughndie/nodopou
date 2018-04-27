class List < ApplicationRecord

  #開祖
  belongs_to :user

  #実行者たち
  has_many   :mylists, dependent: :destroy
  has_many   :users,   through:   :mylists

  validates :user_id,  presence: { message: "ユーザーが特定できません" }
  validates :content,  presence: { message: "内容を入力してください" },
                       length:   { maximum: 100,
                                   message: "内容は100文字まで入力できます" }

  class << self

    def search(keyword)
      if keyword
        keyword_arys = keyword.split(/[\s　]+/)
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

  def availed?
    user_count == 0
  end

  def joined_user
    increment!(:user_count, by = 1)
  end

  def leaved_user
    decrement!(:user_count, by = 1)
  end

  def set_create_user_none
    update_attribute(user_id: 0)
  end

end
