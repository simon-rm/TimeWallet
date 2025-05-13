class User < ApplicationRecord
  has_many :days, dependent: :destroy

  def today
    days.last if days.last&.current?
  end
end
