class Day < ApplicationRecord
  belongs_to :user

  enum :current_mode, %i[life work]
end
