class CartItemsController < ApplicationController
  helper_method :cart, :food_from_food_id, :food_total_price_with_tax

  def index; end

  def create
    add_food_to_cart(params[:cart][:food_id].to_i, params[:cart][:quantity].to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to root_url
  end

  def update
    update_food_count_in_cart(params[:cart][:food_id].to_i, params[:cart][:quantity].to_i)
    flash[:notice] = 'カート情報を更新しました。'
    redirect_to cart_items_path
  end

  def destroy
    destroy_food_in_cart(params[:food_id].to_i)
    flash[:notice] = 'カートから削除しました。'
    redirect_to cart_items_path
  end

  private

  def add_food_to_cart(food_id, quantity)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['quantity'] += quantity
        return
      end
    end
    cart << { food_id: food_id.to_i, quantity: quantity.to_i }
  end

  def update_food_count_in_cart(food_id, quantity)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['quantity'] = quantity
        return
      end
    end
  end

  def destroy_food_in_cart(food_id)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart.delete(cart_item)
        return
      end
    end
  end

  def food_total_price_with_tax(food_id)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        return Food.find(cart_item['food_id']).price_with_tax * cart_item['quantity']
      end
    end
  end

  def food_from_food_id(food_id)
    Food.find(food_id)
  end
end
