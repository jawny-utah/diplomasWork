class PagesController < ApplicationController
  def index
    @categories = Category.all
    @brands = Brand.all
    @colors = Color.all
    @pagy, @wears = pagy(filtered_wears)
  end

  private

  def filtered_wears
    Wear.filter(params.slice(:subcategory, :color, :brand, :sex))
  end
end
