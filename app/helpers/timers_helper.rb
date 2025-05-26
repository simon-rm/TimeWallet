module TimersHelper
  def timer_state(timer)
    if timer.running?
      :running
    elsif timer.day.active?
      :paused
    else
      :old
    end
  end

  def format_duration(seconds)
    hours = seconds / 3600.0
    rounded_hours = (hours * 2).round / 2.0 # rounds to .5 or .0
    rounded_hours = rounded_hours.to_i if rounded_hours.to_s.ends_with?(".0")
    "#{rounded_hours}h"
  end
end