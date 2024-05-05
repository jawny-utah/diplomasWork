class ApplicationController < ActionController::Base
  before_action :set_current_user_hash
  helper_method :current_user
  helper_method :current_order
  helper_method :logged_in?
  helper_method :require_authorization
  helper_method :already_authorized?
  include Pagy::Backend

  def set_current_user_hash
    cookies[:user_hash] = SecureRandom.hex(4) if cookies[:user_hash].nil?
  end

  def current_order
    if logged_in?
      @current_order ||= current_user.orders.where(status: :draft).last
    else
      @current_order ||= Order.where(status: :draft, uniq_user_hash: cookies[:user_hash]).last
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_authorization
    redirect_to root_path unless logged_in?
  end

  def already_authorized?
    redirect_to root_path if logged_in?
  end
end
