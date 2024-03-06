class PurchaseDetailsController < ApplicationController
  before_action :authenticate_user!
  def create
    purchase_detail = PurchaseDetail.new(purchase_detail_params)
    purchase_detail.user_trying_purchase = current_user
    purchase_detail.set_purchase(current_user)
    if purchase_detail.save
      flash[:notice] = 'カートに追加しました。'
      redirect_to foods_url
    else
      flash[:alert] = 'カートに追加できませんでした。'
      redirect_back fallback_location: root_path
    end

  end

  private

  def purchase_detail_params
    params.require(:purchase_detail).permit(:food_id, :number)
  end
end
