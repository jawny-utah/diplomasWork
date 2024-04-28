class WearOrderDetailSizesController < ApplicationController
  def update
    @size = WearOrderDetailSize.find(params[:id])
    @size.update(wear_order_detail_size_params)
    @order = @size.wear_order.order
    @wear_orders = @order.wear_orders

    respond_to do |format|
      format.turbo_stream { render "orders/update_modal" }
    end
  end

  def destroy
    @size = WearOrderDetailSize.find(params[:id])
    @order = @size.wear_order.order
    @wear_orders = @order.wear_orders
    @size.destroy

    respond_to do |format|
      format.turbo_stream { render "orders/update_modal" }
    end
  end

  private

  def wear_order_detail_size_params
    params.require(:wear_order_detail_size).permit(:quantity)
  end
end
