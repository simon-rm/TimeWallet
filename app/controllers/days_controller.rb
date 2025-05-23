class DaysController < ApplicationController
  def show
    @day = Day.find_by(id: params[:id]) || @user.current_day || Day.finish_and_start_for(@user).switch_to!(:life)
  end

  def edit
  end

  def index
    @days = @user.days.order(id: :desc).except(@user.current_day)
  end

  def switch_timer
    @day = @user.current_day.switch_to!(params[:name])
    render :show
  end
end
