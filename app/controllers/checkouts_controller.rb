class CheckoutsController < ApplicationController
  def show
    @order = current_order
    return if @order.nil?

    @wear_orders = @order.wear_orders
  end

  def submit_order
    @order = current_order
    @wear_orders = @order.wear_orders

    if @order.update(order_params)
      create_user_if_non_found
    else
      flash[:error] = @order.errors.full_messages.map { |a| a.gsub("Shipment order ", "") }
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def create_user_if_non_found
    return if @order.user.present?

    if current_user.nil?
      if find_user_by_email.nil? || find_user_by_phone.nil?
        user_password = SecureRandom.hex(6)
        new_user = User.create(full_name: order_params[:shipment_order_attributes][:customer_name],
                               email: order_params[:shipment_order_attributes][:customer_email],
                               phone_number: order_params[:shipment_order_attributes][:customer_phone],
                               password: user_password,
                               password_confirmation: user_password)
        @order.update(user_id: new_user.id)
        flash[:notice] = "Вас було успішно зареєстровано"
        session[:user_id] = new_user.id
      end
    else
      @order.update(user_id: current_user.id)
    end
  end

  def order_params
    params.require(:order).permit(:user_id, :status, :payment_type, :comment,
           shipment_order_attributes: %i[customer_name customer_town customer_phone customer_email shipment_type current_user_id],
           wear_orders_attributes: [:wear_id, wear_order_detail_sizes_attributes: %i[cloth_length classic_size quantity shoulders_length chest_size
                                                 arms_length arms_width belt_length thighs_length inner_seam_length]])
  end

  def find_user_by_email
    User.find_by(email: order_params[:shipment_order_attributes][:customer_email])
  end

  def find_user_by_phone
    User.find_by(phone_number: order_params[:shipment_order_attributes][:customer_phone])
  end
end
