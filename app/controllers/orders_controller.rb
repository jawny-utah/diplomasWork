class OrdersController < ApplicationController
  def create
    if User.last.orders.where(status: :draft).empty?
      @order = Order.create(order_params)
    else
      order_params[:wear_orders_attributes].each do |key, val|
        next if val["quantity"] == "0"

        User.last.orders.where(status: :draft).last.wear_orders.create(val)
      end
    end
  end

  def show_cart_modal
    render partial: "shared/cart", layout: false
  end

  private

  def order_params
    params.require(:order).permit(:user_id, wear_orders_attributes: [:wear_id, :classic_size, :quantity,
           wear_order_detail_size_attributes: %i[cloth_length shoulders_length chest_size
                                                 arms_length arms_width belt_length thighs_length inner_seam_length]])
  end
end
