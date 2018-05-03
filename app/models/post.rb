class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :picture, presence: true
end
