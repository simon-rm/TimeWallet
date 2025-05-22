class Day < ApplicationRecord
  class SwitchAfterFinishError < StandardError ; end
  class CurrentSwitchError < StandardError ; end

  DEFAULT_CONFIG = {
    timers_attributes: [
      { name: :work, expected_duration: 8.hours },
      { name: :life, expected_duration: 8.hours },
      { name: :sleep, expected_duration: 8.hours }
    ]
  }

  belongs_to :user
  has_many :timers

  accepts_nested_attributes_for :timers

  def self.finish_and_start_for(user)
    config = user.current_day&.config || DEFAULT_CONFIG
    user.current_day&.update!(finished_at: Time.current)
    user.days.create!(config)
  end

  def started_at
   Time.current - timers.sum(&:total_duration)
  end

  def active?
    finished_at.nil?
  end

  def switch_to!(name)
    raise SwitchAfterFinishError if finished_at?
    raise CurrentSwitchError if current_timer&.name == name.to_s

    woke_up = night_sleeping?
    current_timer&.stop!

    today = woke_up ? Day.finish_and_start_for(user) : self
    today.timers.find_by!(name:).run!
    today
  end

  def current_timer
    timers.detect(&:running?)
  end

  def config
    {
      timers_attributes: timers.as_json(only: %i[name expected_duration])
    }
  end

  private

  def night_sleeping?
    current_timer&.name == "sleep" && started_at.yesterday?
  end
end
