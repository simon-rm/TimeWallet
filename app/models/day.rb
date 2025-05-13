class Day < ApplicationRecord
  belongs_to :user

  # TODO: validate either current_mode or ended_at is nil

  enum :current_mode, %i[life work]

  def switch_to!(new_mode)
    update!(current_mode: new_mode, "#{current_mode}_seconds": elapsed_seconds)
  end

  def finish!
    switch_to!(nil)
    update!(ended_at: Time.current)
  end

  def current?
    ended_at.nil?
  end

  private

  def elapsed_seconds
    Time.current - last_switched_at
  end

  def last_switched_at
    created_at + work_seconds + life_seconds
  end
end
