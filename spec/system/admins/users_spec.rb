require 'rails_helper'
require 'spec_helper'

RSpec.describe 'ユーザ管理' do
  context '管理者ログイン時' do
    before do
      sign_in create(:admin)
    end

    describe 'ユーザ一覧' do
      let!(:user) { create(:user) }
      it 'ユーザを一覧できること' do
        visit admins_users_path
        expect(page).to have_content(user.last_name)
      end
    end

    describe 'ユーザ削除' do
      let!(:user) { create(:user) }
      it 'ユーザを削除できること' do
        visit admins_users_path
        expect(page).to have_content(user.last_name)
        click_button '削除'
        expect(page).to have_content('ユーザを削除しました。')
        expect(page).to_not have_content(user.last_name)
      end
    end
  end
end
