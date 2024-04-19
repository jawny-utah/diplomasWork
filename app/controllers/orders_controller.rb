class OrdersController < ApplicationController
  def create
    if logged_in?
      if current_order
        current_order.update(order_params)
      else
        @order = Order.create(order_params)
      end
    else
      if cookies[:user_hash]
        if current_order.present?
          current_order.update(order_params)
        else
          Order.create(order_params.merge(uniq_user_hash: cookies[:user_hash]))
        end
      else
        cookies[:user_hash] = SecureRandom.hex(4)
        Order.create(order_params.merge(uniq_user_hash: cookies[:user_hash]))
      end
    end

    respond_to do |format|
      format.turbo_stream { render "orders/update_modal" }
    end
  end

  def update
    @order ||= Order.find_by(id: params[:id])
    @order.update(order_params)

    respond_to do |format|
      format.turbo_stream { render "orders/update_modal" }
    end
  end

  def show_cart_modal
    render partial: "shared/cart", layout: false
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :payment_type, :comment,
           shipment_order_attributes: %i[customer_name customer_town customer_phone customer_email shipment_type],
           wear_orders_attributes: [:wear_id, wear_order_detail_sizes_attributes: %i[cloth_length classic_size quantity shoulders_length chest_size
                                                 arms_length arms_width belt_length thighs_length inner_seam_length]])
  end
end
