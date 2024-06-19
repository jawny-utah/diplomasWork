class PagesController < ApplicationController
  def index
    @categories = Category.all.load_async
    @brands = Brand.all.load_async
    @colors = Color.all.load_async
    @final_relation = []
    if params[:full_name].present?
      @final_relation = filtered_wears.search_by_full_name(params[:full_name])
    else
      @final_relation = filtered_wears
    end
    @pagy, @wears = pagy(@final_relation)
  end

  def delivery_info; end

  def payment_info; end

  private

  def filtered_wears
    Wear.filter(params.slice(:subcategory, :color, :brand, :sex))
  end
end
