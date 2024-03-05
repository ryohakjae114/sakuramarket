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
  end
end
