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
  
  class << self
    def all_format_gon_params
      all.map do |list|
        map_gon_hah(list)
      end
    end

    def find_format_gon_params(ids)
      find(ids).map do |list|
        map_gon_hah(list)
      end
    end

    def find_format_gon_params_by(id)
      map_gon_hah(self.find_by(id: id))
    end

    private

    def gon_params
      [:id, :user_id, :content, :user_count]
    end

    def map_gon_hah(list)
      return if list.blank?
      Hash[
        gon_params.map do |ep|
          [ep, list.send(ep)]
        end
      ]
    end
  end

  def destroy_or_leaved(cuser)
    return destroy if user_count <= 1
    cuser.unavail(self)
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
