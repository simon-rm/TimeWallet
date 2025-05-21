class DaysController < ApplicationController
  def show
    @day = Day.find_by(id: params[:id]) || @user.current_day || Day.finish_and_start_for(@user).switch_to!(:life)
  end

  def update
    @day = Day.find(params[:id])

    if @day.update(day_params)
      redirect_to @day
    else
      render :show, status: :unprocessable_entity
    end
  end

  def index
    @days = @user.days.order(id: :desc).except(@user.current_day)
  end

  def switch_timer
    @user.current_day.switch_to!(params[:name])
    redirect_to @user.current_day
  end

  private

  def day_params
    params.require(:day).permit(timers_attributes: %i[name duration expected_duration])
                        .with_defaults(@user.default_day_config)
  end
end
