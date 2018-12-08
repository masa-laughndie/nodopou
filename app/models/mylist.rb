class Mylist < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :user_id, presence: true
  validates :list_id, presence: true

  class << self
    def all_format_gon_params
      self.all.map do |mylist|
        map_gon_hah(mylist)
      end
    end

    def find_format_gon_params(ids)
      self.find(ids).map do |mylist|
        map_gon_hah(mylist)
      end
    end

    def find_format_gon_params_by(id)
      map_gon_hah(self.find_by(id))
    end

    private

    def gon_params
      [:id, :user_id, :list_id, :active, :check, :strong, :check_count, :running_days, :max_running_days]
    end

    def map_gon_hah(mylist)
      return if mylist.blank?
      Hash[
        gon_params.map do |ep|
          [ep, mylist.send(ep)]
        end
      ]
    end
  end

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
    new_running_days = running_days + 1
    
    if running_days_record_update?
      update_attributes(running_days: new_running_days,
                        max_running_days: new_running_days,
                        check: false)
    else
      update_attributes(running_days: new_running_days, check: false)
    end
  end

  def reset_running_days
    update_attribute(:running_days, 0) if self.running_days != 0
  end

  private

  def running_days_record_update?
    max_running_days <= running_days
  end
end
