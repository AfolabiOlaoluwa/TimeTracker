class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :clock_entries
  has_many :active_clock_entries, -> { where(time_out: nil) }, class_name: 'ClockEntry'
  has_many :inactive_clock_entries, -> { where.not(time_out: nil) }, class_name: 'ClockEntry'
end
