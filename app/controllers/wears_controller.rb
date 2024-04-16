class WearsController < ApplicationController
  def show
    @wear = Wear.find(params[:id])
  end

  def detail_size_show
    @wear = Wear.find(params[:id])
    render partial: "wears/detail_size_show", layout: false
  end
end
