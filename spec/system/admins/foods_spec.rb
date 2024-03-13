require 'rails_helper'

RSpec.describe '商品管理' do
  context '管理者ログイン時' do
    before do
      sign_in create(:admin)
    end

    describe '商品新規作成' do
      it '商品を新規作成できること' do
        visit new_admins_food_path
        fill_in '商品名', with: 'ぶどう'
        fill_in '金額(税抜)', with: '200'
        click_button '登録'
        expect(page).to have_content '登録しました。'
        # TODO 一覧画面にデータが追加されたことを確認する
      end
    end

    describe '商品一覧' do
      let!(:food) { create(:food) }
      it '商品一覧画面を閲覧できること' do
        visit admins_foods_path
        expect(page).to have_content(food.name)
      end
    end

    describe '商品情報変更' do
      let!(:food) { create(:food) }
      it '商品情報を変更できること' do
        visit edit_admins_food_path(food)
        fill_in '商品名', with: 'はっちゃん'
        click_button '変更'
        expect(find('input[name="food[name]"]').value).to eq 'はっちゃん'
      end
    end

    describe '商品削除' do
      let(:food) { create(:food) }
      it '商品を削除できること' do
        visit edit_admins_food_path(food)
        click_button '削除'
        expect(page).to have_content '削除しました。'
      end
    end
  end
end
