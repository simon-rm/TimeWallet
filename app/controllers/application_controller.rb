class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_user
  around_action :switch_time_zone

  private

  def switch_time_zone(&block)
    Time.use_zone(cookies[:time_zone], &block)
  end

  def set_user
    @user = User.find_or_create_by(guest_token:)
  end

  private

  def guest_token
    cookies.permanent.signed[:guest_token] ||= SecureRandom.uuid
  end
end
