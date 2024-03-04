class Admins::FoodsController < AdminsController
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :price_without_tax, :description, :displayed, :position)
  end
end
