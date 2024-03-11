require 'rails_helper'
require 'spec_helper'

RSpec.describe '購入機能' do
  let(:user) { create(:user) }
  context 'ユーザログイン時' do
    before do
      sign_in user
    end

    describe '購入' do
      let(:food) { create(:food) }
      let(:purchase) { create(:purchase, user: user) }
      let!(:purchase_detail) { create(:purchase_detail, food: food, purchase: purchase) }
      it 'カートの内容を購入できること' do
        visit new_purchase_path(purchase: { id: purchase.id })
        click_button '購入を確定する'
        expect(page).to have_content('購入しました。')
      end
    end

    describe '購入一覧' do
      let(:food) { create(:food) }
      let(:payment_date_time) { Time.current }
      let!(:purchase) { create(:purchase, user: user, paid_at: payment_date_time) }
      let(:purchase_detail) { create(:purchase_detail, food: food, purchase: purchase) }
      it '購入一覧画面を閲覧できること' do
        visit purchases_path
        expect(page).to have_content(payment_date_time)
      end
    end

    describe '購入詳細' do
      let(:food) { create(:food) }
      let(:payment_date_time) { Time.current }
      let!(:purchase) { create(:purchase, user: user, paid_at: payment_date_time) }
      let!(:purchase_detail) { create(:purchase_detail, food: food, purchase: purchase) }
      it '購入詳細画面を閲覧できること' do
        visit purchase_path(purchase)
        expect(page).to have_content(food.name)
      end
    end
  end
end
