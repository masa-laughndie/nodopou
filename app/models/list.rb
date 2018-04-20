class List < ApplicationRecord

  belongs_to :user


  validates :user_id,  presence: { message: "ユーザーが特定できません" }
  validates :content,  presence: { message: "内容を入力してください" },
                       length:   { maximum: 100,
                                   message: "内容は100文字まで入力できます" }

end
