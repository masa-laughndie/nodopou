class List < ApplicationRecord
  extend Search

  search_fields :content

  belongs_to :user

  has_many   :mylists, dependent: :destroy
  has_many   :users,   through:   :mylists

  validates :user_id,  presence: { message: "ユーザーが特定できません" }
  validates :content,  presence: { message: "内容を入力してください" },
                       length:   { maximum: 60,
                                   message: "内容は60文字まで入力できます" }

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
