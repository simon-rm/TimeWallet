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
    now = Time.current
    user.current_day&.update!(finished_at: now)
    previous_day_config = user.current_day&.config
    user.days.create!(started_at: now, **(previous_day_config || DEFAULT_CONFIG))
  end

  def active?
    started_at? && finished_at.nil?
  end

  def switch_to!(name)
    raise SwitchAfterFinishError if finished_at?
    raise CurrentSwitchError if current_timer&.name == name.to_s

    next_day = Day.finish_and_start_for(user) if night_sleeping?
    current_timer&.stop!

    current_day = next_day || self
    current_day.timers.find_by!(name:).run!
    current_day
  end

  def current_timer
    timers.detect(&:running?)
  end

  protected

  def config
    timers.as_json(only: %i[name expected_duration])
  end

  private

  def night_sleeping?
    current_timer&.name == "sleep" && started_at.before?(Time.zone.yesterday)
  end
end
