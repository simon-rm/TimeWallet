class DaysController < ApplicationController
  def show
    @day = Day.find_by(id: params[:id]) || @user.current_day || Day.finish_and_start_for(@user).switch_to!(:life)
  end

  def edit
    @day = Day.find(params[:id])
  end

  def update
    @day = Day.find(params[:id])

    if @day.update(day_params)
      redirect_to @day
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @days = @user.days.order(started_at: :desc)
  end

  def switch_timer
    @day = @user.current_day.switch_to!(params[:name])
    render :show
  end

  private

  def day_params
    params.require(:day).permit(timers_attributes: %i[id expected_time])
  end
end
