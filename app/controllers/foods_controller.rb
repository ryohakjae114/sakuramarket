class FoodsController < ApplicationController
  before_action :set_food, only: :show

  def index
    @foods = Food.displayed.order(:position)
  end

  def show
    @cart_detail =
      if current_user.include_in_cart?(@food)
        current_user.cart.purchase_details.find_by(food_id: @food.id)
      else
        current_user.cart.purchase_details.build
      end
  end

  private

  def food_params
    params.require(:food).permit(:name, :price_without_tax, :description, :displayed, :position, :image)
  end

  def set_food
    @food = Food.find(params[:id])
  end
end
