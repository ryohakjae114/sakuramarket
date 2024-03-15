class CartItemsController < ApplicationController
  helper_method :cart, :food_from_food_id, :food_total_price_with_tax

  def index; end

  def create
    add_food_to_cart(params[:cart][:food_id].to_i, params[:cart][:quantity].to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to root_url
  end

  def update
    update_food_count_in_cart(params[:index], params[:cart][:quantity])
    flash[:notice] = 'カート情報を更新しました。'
    redirect_to cart_items_url
  end

  def destroy
    destroy_food_in_cart(params[:index])
    flash[:notice] = 'カートから削除しました。'
    redirect_to cart_items_url
  end

  private

  def add_food_to_cart(food_id, quantity)
    food_index_in_cart = cart.find_index { |cart_item| cart_item['food_id'] == food_id.to_i }
    if food_index_in_cart.present?
      cart[food_index_in_cart]['quantity'] += quantity.to_i
    else
      cart << { food_id: food_id.to_i, quantity: quantity.to_i }
    end
  end

  def update_food_count_in_cart(index, quantity)
    cart[index.to_i]['quantity'] = quantity.to_i
  end

  def destroy_food_in_cart(index)
    cart.delete_at(index.to_i)
  end

  def food_total_price_with_tax(index)
    Food.find(cart[index.to_i]['food_id']).price_with_tax * cart[index.to_i]['quantity']
  end

  def food_from_food_id(food_id)
    Food.find(food_id)
  end
end
