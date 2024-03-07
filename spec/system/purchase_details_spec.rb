require 'rails_helper'
require 'spec_helper'

RSpec.describe 'カート機能' do
  let(:user) { create(:user) }
  context 'ユーザログイン時' do
    before do
      sign_in user
    end

    describe 'カート一覧' do
      let(:food) { create(:food) }
      let(:purchase) { create(:purchase, user: user) }
      let!(:purchase_detail) { create(:purchase_detail, food: food, purchase: purchase) }
      it 'カート一覧画面を閲覧できること' do
        visit purchase_details_path
        expect(page).to have_content('はっつぁん')
      end
    end

    describe 'カートに商品を追加' do
      let!(:food) { create(:food) }
      it 'カートに商品を追加できること' do
        visit food_path(food)
        fill_in '数量', with: '10'
        click_button 'カートに追加'
        visit purchase_details_path
        expect(page).to have_content(food.name)
      end

      let(:purchase) { create(:purchase, user: user) }
      let!(:purchase_detail) { create(:purchase_detail, purchase: purchase, food: food) }
      it 'すでにカートに入っている商品は数量が足されること' do
        visit food_path(purchase_detail.food)
        fill_in '数量', with: 10
        click_button 'カートに追加'
        visit purchase_details_path
        expect(page).to have_content(11*food.price_with_tax)
      end
    end

    describe 'カート詳細からカートの中の商品の数量を変更' do
      let(:purchase) { create(:purchase, user: user) }
      let(:food) { create(:food) }
      let!(:purchase_detail) { create(:purchase_detail, purchase: purchase, food: food) }
      it 'カート詳細からカートの中の商品の数量を変更できること' do
        visit purchase_details_path
        fill_in 'purchase_detail_number', with: 30
        click_button '数量を変更'
        expect(page).to have_content(30*food.price_with_tax)
      end
    end

    describe 'カートの商品を削除' do
      let(:purchase) { create(:purchase, user: user) }
      let(:food) { create(:food) }
      let!(:purchase_detail) { create(:purchase_detail, purchase: purchase, food: food) }
      it 'カートの商品を削除できること' do
        visit purchase_details_path
        click_on '削除'
        expect(page).not_to have_content(food.name)
      end
    end
  end
end
