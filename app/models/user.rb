class User < ApplicationRecord
  has_many :days, dependent: :destroy
end
