class ApplicationController < ActionController::Base
  # include CartsHelper

  def cart
    session[:cart] ||= []
  end

  def add_food_to_cart(food_id, number)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['number'] += number
        return
      end
    end
    cart << { food_id: food_id.to_i, number: number.to_i }
  end

  def update_food_count_in_cart(food_id, number)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['number'] = number
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
        return Food.find(cart_item['food_id']).price_with_tax * cart_item['number']
      end
    end
  end

  def food_from_food_id(food_id)
    Food.find(food_id)
  end
end
