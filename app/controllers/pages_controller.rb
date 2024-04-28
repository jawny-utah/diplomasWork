class PagesController < ApplicationController
  def index
    @categories = Category.all.load_async
    @brands = Brand.all.load_async
    @colors = Color.all.load_async
    @pagy, @wears = pagy(filtered_wears)
  end

  private

  def filtered_wears
    Wear.filter(params.slice(:subcategory, :color, :brand, :sex))
  end
end
