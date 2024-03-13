class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: %i[ show]

  def index
    @purchases = current_user.purchases.where.not(paid_at: nil).order(:paid_at)
  end

  def new
    @purchase = current_user.purchases.build
    @purchase_details = cart.map { |cart_item| @purchase.purchase_details.build(food_id: cart_item['food_id'], number: cart_item['number']) }
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    @purchase.paid_at = Time.current
      @purchase_details = cart.map { |cart_item| @purchase.purchase_details.build(food_id: cart_item['food_id'], number: cart_item['number']) }
    @purchase.save_with_purchase_details!(@purchase_details)
    session.delete(:cart)
    flash[:notice] = '購入しました。'
    redirect_to root_url
  end

  def show
  end

  private

  def set_purchase
    @purchase = current_user.purchases.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:delivery_on, :delivery_time_zone, :address)
  end
end
