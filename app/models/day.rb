class Day < ApplicationRecord
  class SwitchAfterFinishError < StandardError ; end
  belongs_to :user
  has_many :timers

  accepts_nested_attributes_for :timers

  def active?
    started_at? && finished_at.nil?
  end

  def switch_to!(name)
    raise SwitchAfterFinishError if finished_at?
    current_timer&.stop!
    timers.except(current_timer).find_by!(name:).run! if name
  end

  def current_timer
    timers.detect(&:running?)
  end
end
