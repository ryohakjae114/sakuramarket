# frozen_string_literal: true
class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :build_purchase_and_purchase_detail, only: %i[new create]
  before_action :set_purchase, only: :show

  helper_method :cart

  def index
    @purchases = current_user.purchases.order(:paid_at)
  end

  def new; end

  def create
    @purchase.assign_attributes(delivery_on: purchase_params['delivery_on'],
                                delivery_time_zone: purchase_params['delivery_time_zone'],
                                address: purchase_params['address'])
    @purchase.save!
    session.delete(:cart)
    flash[:notice] = '購入しました。'
    redirect_to root_url
  end

  def show; end

  private

  def set_purchase
    @purchase = current_user.purchases.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:delivery_on, :delivery_time_zone, :address)
  end

  def build_purchase_and_purchase_detail
    @purchase = current_user.purchases.build
    @purchase_details = cart.map do |cart_item|
      @purchase.purchase_details.build(food_id: cart_item['food_id'], number: cart_item['number'])
    end
    redirect_to root_url if @purchase_details.empty?
  end
end
