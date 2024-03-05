require 'rails_helper'
require 'spec_helper'

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
        expect do
          click '登録'
          expect('page').to have_content '登録しました。'
        end
      end
    end

    describe '商品一覧' do
      let(:food) { create(:food) }
      it '商品一覧画面を閲覧できること' do
        expect do
          visit admins_foods_path
          expect('page').to have_css('.card')
        end
      end
    end

    describe '商品情報変更' do
      let(:food) { create(:food) }
      it '商品情報を変更できること' do
        expect do
          visit admins_food_path(:food)
          fill_in '商品名', with: 'はっちゃん'
          click '変更'
          expect('page').to have_content 'はっちゃん'
        end
      end
    end

    describe '商品削除' do
      let(:food) { create(:food) }
      it '商品を削除できること' do
        expect do
          visit admins_food_path(:food)
          click '削除'
          expect('page').to have_content '削除しました。'
        end
      end
    end
  end
end
