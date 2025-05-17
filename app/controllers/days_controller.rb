class DaysController < ApplicationController
  before_action :set_user

  def new; end

  def show
    @day = Day.find(params[:id])
  end

  def create
    day = @user.days.new(default_day_config)
    if day.save
      day.switch_to!(:life)
      redirect_to day
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @days = @user.days
  end

  def switch
    @user.current_day.switch_to!(params[:mode])
    redirect_to @user.current_day
  end

  def finish
    @user.current_day.switch_to!(nil)
    update!(finished_at: Time.current)
    redirect_to @user.current_day
  end

  def current_day
    redirect_to @user.current_day || new_day_path
  end

  private

  def default_day_config
    {
      started_at: Time.current,
      timers_attributes: [ { name: :work }, { name: :life }, { name: :sleep } ]
    }
  end

  def set_user
    @user = User.find_or_create_by(guest_token: session.id.cookie_value)
  end
end
