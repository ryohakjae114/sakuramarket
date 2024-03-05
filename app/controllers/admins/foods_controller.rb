class Admins::FoodsController < AdminsController
  before_action :set_food, only: %i[ edit update move_higher move_lower ]
  def index
    @foods = Food.all.order(:position)
  end

  def move_higher
    @food.move_higher
    redirect_to admins_foods_url
  end

  def move_lower
    @food.move_lower
    redirect_to admins_foods_url
  end
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:notice] = '登録しました。'
      redirect_to admins_foods_url
    else
      flash[:alert] = '登録に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      flash[:notice] = '変更しました。'
      redirect_to edit_admins_food_url(@food)
    else
      flash[:alert] = '変更できませんでした。'
      render :edit, status: :unprocessable_entity
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
