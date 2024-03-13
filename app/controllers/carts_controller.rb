class CartsController < ApplicationController

  helper_method :cart

  def show
  end

  def add_food
    add_food_to_cart(params[:cart][:food_id].to_i, params[:cart][:number].to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to root_url
  end

  def update_food_count
    update_food_count_in_cart(params[:cart][:food_id].to_i, params[:cart][:number].to_i)
    flash[:notice] = 'カート情報を更新しました。'
    redirect_to cart_path
  end


  def destroy_food
    destroy_food_in_cart(params[:food_id].to_i)
    flash[:notice] = 'カートから削除しました。'
    redirect_to cart_path
  end
end
