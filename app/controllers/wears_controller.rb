class WearsController < ApplicationController
  def show
    @wear = Wear.find(params[:id])
    @order = current_order || Order.new
  end
end
