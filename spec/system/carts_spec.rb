require 'rails_helper'

RSpec.describe '購入機能' do
  let(:user) { create(:user) }

  context 'ユーザログイン時' do
    let!(:food) { create(:food) }

    before do
      sign_in user
      visit food_path(food)
      fill_in '数量', with: '10'
      click_button 'カートに追加'
    end

    describe '購入' do
      it 'カートの内容を購入できること' do
        visit new_purchase_path
        click_button '購入を確定する'
        expect(page).to have_content('購入しました。')
        visit purchases_path
        expect(page).to have_selector('tbody')
      end
    end

    describe '購入詳細' do
      it '購入詳細画面を閲覧できること' do
        visit new_purchase_path
        click_button '購入を確定する'
        visit purchase_path(food.purchase_details.first.purchase)
        expect(page).to have_content(food.name)
      end
    end
  end
end
