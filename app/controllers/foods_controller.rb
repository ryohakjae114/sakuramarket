class FoodsController < ApplicationController
  before_action :set_food, only: :show

  def index
    @foods = Food.displayed.order(:position)
  end

  def show
  end

  def food_params
    params.require(:food).permit(:name, :price_without_tax, :description, :displayed, :position, :image)
  end

  def set_food
    @food = Food.find(params[:id])
  end
end
