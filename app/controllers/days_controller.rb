class DaysController < ApplicationController
  before_action :set_user
  before_action :redirect_to_today_or_new_day, only: %i[switch_mode today finish]

  def new; end

  def show
    @day = Day.find(params[:id])
  end

  def create
    day = Day.new(user: @user)
    if day.save
      redirect_to day
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @days = @user.days
  end

  def switch_mode
    @user.today.switch_mode!(params[:mode])
  end

  def finish
    @user.today.finish!
  end

  def today; end

  private

  def redirect_to_today_or_new_day
    redirect_to @user.today || new_day_path
  end

  def set_user
    @user = User.find_or_create_by(guest_token: session.id.cookie_value)
  end
end
