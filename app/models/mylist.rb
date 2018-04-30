class Mylist < ApplicationRecord
  
  belongs_to :user
  belongs_to :list

  validates :user_id, presence: true
  validates :list_id, presence: true

  def toggle!(attribute)
    update(attribute.to_sym => !self.send("#{attribute}"))
  end

  def toggle_check_and_count!
    if self.check?
      update_attributes(check_count: self.check_count - 1, check: false)
    else
      update_attributes(check_count: self.check_count + 1, check: true)
    end
  end

  def add_running_days_and_reset_check
    update_attributes(running_days: self.running_days + 1, check: false)
  end

  def remove_running_days
    decrement!(:running_days, by = 1)
  end

  def reset_running_days
    if self.running_days != 0
      update_attribute(:running_days, 0)
    end
  end
end
