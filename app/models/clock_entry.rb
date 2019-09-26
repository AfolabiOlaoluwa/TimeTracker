class ClockEntry < ApplicationRecord
  belongs_to :user

  validates :purpose, presence: true

  def set_time_in
    self.time_in = Time.now
  end
end