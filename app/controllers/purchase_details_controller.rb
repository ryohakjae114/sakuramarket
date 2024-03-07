class PurchaseDetailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_details = current_user.cart.purchase_details.order(:id)
  end

  def create
    purchase_detail = current_user.cart.purchase_details.build(purchase_detail_params)
    if purchase_detail.save
      flash[:notice] = 'カートに追加しました。'
      redirect_to foods_url
    else
      flash[:alert] = 'カートに追加できませんでした。'
      redirect_back fallback_location: root_path
    end
  end

  def update
    @purchase_detail = current_user.cart.purchase_details.find(params[:id])
    if @purchase_detail.update(purchase_detail_params)
      flash[:notice] = '数量を変更しました。'
      redirect_to purchase_details_url
    else
      flash[:alert] = '数量を変更できませんでした。'
      redirect_back fallback_location: root_path
    end
  end

  def add_number
    @purchase_detail = current_user.cart.purchase_details.find(params[:purchase_detail][:id])
    @purchase_detail.add_number!((params[:purchase_detail][:number]).to_i)
    flash[:notice] = 'カートに追加しました。'
    redirect_to food_path(@purchase_detail.food)
  end

  def destroy
    purchase_detail =  current_user.cart.purchase_details.find(params[:id])
    purchase_detail.destroy!
    flash[:notice] = '商品を削除しました。'
    redirect_to purchase_details_url
  end

  private

  def purchase_detail_params
    params.require(:purchase_detail).permit(:food_id, :number)
  end
end
