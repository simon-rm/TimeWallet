class Timer < ApplicationRecord
  class AlreadyRunningError < StandardError; end
  class NotRunningError < StandardError; end

  def run!
    raise AlreadyRunningError if running?
    update!(running_since: Time.current)
  end

  def running?
    running_since?
  end

  def total_seconds
    seconds + current_duration
  end

  def stop!
    raise NotRunningError unless running?
    update!(running_since: nil, seconds: total_seconds)
  end

  private

  def current_duration
    return 0 unless running?
    (Time.current - running_since).round
  end
end