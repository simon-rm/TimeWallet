class Timer < ApplicationRecord
  belongs_to :day, optional: true
  class AlreadyRunningError < StandardError; end
  class NotRunningError < StandardError; end

  def run!
    raise AlreadyRunningError if running?
    update!(running_since: Time.current)
  end

  def running?
    running_since?
  end

  def time_left
    expected_duration - total_duration
  end

  def total_duration
    duration + current_duration
  end

  def stop!
    raise NotRunningError unless running?
    update!(running_since: nil, duration: total_duration)
  end

  private

  def current_duration
    return 0 unless running?
    (Time.current - running_since).round
  end
end