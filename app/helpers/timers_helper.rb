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

  def editable_timer?(timer)
    timer.day.active? && current_page?(timer.day)
  end
end