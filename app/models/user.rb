class User < ApplicationRecord
  has_many :days, dependent: :destroy

  def current_day
    days.detect(&:active?)
  end
end
