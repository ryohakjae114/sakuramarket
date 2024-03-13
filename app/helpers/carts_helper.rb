module CartsHelper
  def cart
    session[:cart] ||= []
  end

  def add_to_cart(food_id, number)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['number'] += number
        return
      end
    end
    cart << { food_id: food_id.to_i, number: number.to_i }
  end

  def edit_food_count(food_id, number)
    cart.each do |cart_item|
      if cart_item['food_id'] == food_id
        cart_item['number'] = number
        return
      end
    end
  end

  def delete_food(food_id)
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
end
