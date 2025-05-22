class TimersController < ApplicationController
  before_action :set_timer, only: %i[edit update]

  def edit ; end

  def update
    if @timer.update(timer_params)
      redirect_to @timer.day
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_timer
    @timer = Timer.find(params[:id])
  end

  def timer_params
    params.require(:timer).permit(:expected_time)
  end
end