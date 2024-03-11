class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[ new create show]

  def index
    @purchases = current_user.purchases.where.not(paid_at: nil).order(:paid_at)
  end

  def new
    @cart_details = @purchase.purchase_details.order(:id)
  end

  def create
    @purchase.paid_at = Time.current
    if @purchase.purchase_details.present? && @purchase.update(purchase_params)
      flash[:notice] = '購入しました。'
      redirect_to root_url
    else
      flash[:danger] = '購入に失敗しました。'
      redirect_to root_url
    end
  end

  def show
  end

  private

  def set_purchase
    @purchase = current_user.purchases.find(params[:id] || params[:purchase][:id].to_i)
  end

  def purchase_params
    params.require(:purchase).permit(:delivery_on, :delivery_time_zone, :address)
  end
end
