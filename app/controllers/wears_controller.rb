class WearsController < ApplicationController
  def show
    @wear = Wear.find(params[:id])
  end
end
