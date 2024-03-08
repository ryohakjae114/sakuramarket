class PurchasesController < ApplicationController
  before_action :set_purchase

  def new
    @cart_details = @purchase.purchase_details.order(:id)
  end

  def create
    @purchase.paid_at = Time.current
    if @purchase.update(purchase_params)
      flash[:notice] = '購入しました。'
      redirect_to root_url
    else
      flash[:danger] = '購入に失敗しました。'
      redirect_to root_url
    end
  end

  private

  def set_purchase
    @purchase = current_user.purchases.find(params[:purchase][:id].to_i)
  end

  def purchase_params
    params.require(:purchase).permit(:delivery_on, :delivery_time_zone, :address)
  end
end
