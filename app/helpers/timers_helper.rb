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
end