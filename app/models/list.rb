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

  def destroy_or_leaved(cuser)
    if user_count <= 1
      destroy
    else
      cuser.unavail(self)
    end
  end

  def joined_user
    increment!(:user_count, by = 1)
  end

  def leaved_user
    decrement!(:user_count, by = 1)
  end

  def check_correct_user_count_and_destroy?(real_count)
    if real_count == 0
      destroy
      return true
    elsif user_count != real_count
      update_attribute(:user_count, real_count)
    end
    return false
  end

end
