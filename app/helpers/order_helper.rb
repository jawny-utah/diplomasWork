module OrderHelper
  def order_total_price(order)
    order.total_price.to_s + " ₴"
  end
end
