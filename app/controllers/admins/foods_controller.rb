class Admins::FoodsController < AdminsController

  def index
    @foods = Food.all
  end
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:notice] = '登録しました。'
      # 一覧画面を作成後に↓のリダイレクト先を修正する
      redirect_to new_admins_food_path
    else
      flash[:alert] = '登録に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :price_without_tax, :description, :displayed, :position, :image)
  end
end
