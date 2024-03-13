class CartsController < ApplicationController

  def index
  end

  def update_food_count
    edit_food_count(params[:cart][:food_id].to_i, params[:cart][:number].to_i)
    flash[:notice] = 'カート情報を更新しました。'
    redirect_to carts_path
  end

  def add_food
    add_to_cart(params[:cart][:food_id].to_i, params[:cart][:number].to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to root_url
  end

  def destroy_food
    delete_food(params[:food_id].to_i)
    flash[:notice] = 'カートから削除しました。'
    redirect_to carts_path
  end
end
