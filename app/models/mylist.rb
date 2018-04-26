class Mylist < ApplicationRecord
  
  belongs_to :user
  belongs_to :list

  validates :user_id, presence: true
  validates :list_id, presence: true

  def toggle!(attribute)
    update(attribute.to_sym => !self.send("#{attribute}"))
  end

end
