class UsersController < ApplicationController
  before_action :set_user, :validate_correct_current_user, only: %i(show edit update)
  before_action :already_authorized?, only: %i(new create login)

  def new
    @user = User.new
  end

  def show
    @pagy, @orders = pagy(@user.orders.where.not(status: :draft).order(created_at: :desc))
  end

  def edit;end

  def create
    @user = User.create(user_params)

    if @user.valid?
      session[:user_id] = @user.id
      flash[:notice] = "Користувач був успішно створений"
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      flash[:error] = @user.errors.full_messages
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Ви успішно увійшли"
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      flash[:error] = ["Неправильна пошта або пароль."]
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def update
    if @user.update(user_params)
      flash.now[:notice] = "Зміни збережено"
    else
      flash[:error] = @user.errors.full_messages
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def validate_correct_current_user
    return if current_user.nil? || current_user.id != @user.id
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :phone_number, :address, :password, :password_confirmation)
  end
end
