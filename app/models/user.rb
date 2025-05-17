class User < ApplicationRecord
  has_many :days, dependent: :destroy

  def current_day
    days.last if days.last&.active?
  end
end
