class CartDetailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = current_user.cart
    @cart_details = current_user.cart.purchase_details.order(:id)
  end

  def create
    cart_detail = current_user.cart.purchase_details.build(cart_detail_params)
    if cart_detail.save
      flash[:notice] = 'カートに追加しました。'
      redirect_to foods_url
    else
      flash[:alert] = 'カートに追加できませんでした。'
      redirect_back fallback_location: root_path
    end
  end

  def update
    @cart_detail = current_user.cart.purchase_details.find(params[:id])
    if @cart_detail.update(cart_detail_params)
      flash[:notice] = '数量を変更しました。'
      redirect_to cart_details_url
    else
      flash[:alert] = '数量を変更できませんでした。'
      redirect_back fallback_location: root_path
    end
  end

  def add_number
    @cart_detail = current_user.cart.purchase_details.find(params[:purchase_detail][:id])
    @cart_detail.add_number!((params[:purchase_detail][:number]).to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to food_path(@cart_detail.food)
  end

  def destroy
    cart_detail =  current_user.cart.purchase_details.find(params[:id])
    cart_detail.destroy!
    flash[:notice] = '商品を削除しました。'
    redirect_to cart_details_url
  end

  private

  def cart_detail_params
    params.require(:purchase_detail).permit(:food_id, :number)
  end
end
