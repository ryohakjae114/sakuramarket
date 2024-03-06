require 'rails_helper'
require 'spec_helper'

RSpec.describe 'ユーザ認証' do
  describe 'アカウント作成' do
    it 'アカウント作成できること' do
      expect do
        visit new_user_registration_path
        fill_in 'Eメール', with: 'test@example.com'
        fill_in '姓', with: 'はっつ'
        fill_in '名', with: 'ぁん'
        fill_in '住所', with: '川崎市××区××町3-3-3'
        fill_in 'パスワード', with: '12341234'
        fill_in 'パスワード(確認用)', with: '12341234'
        click 'アカウント作成'
        expect('page').to have_content 'アカウント登録が完了しました。'
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }
    it 'ログインできること' do
      expect do
        visit new_admin_session_path
        fill_in 'Eメール', 'test@example.com'
        fill_in 'パスワード', '12341234'
        click 'ログイン'
        expect('page').to have_content 'ログインしました。'
      end
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }
    it 'ログアウトできること' do
      sign_in user
      expect do
        visit root_path
        click 'ログアウト'
        click 'OK'
        expect('page').to have_content 'ログアウトしました。'
      end
    end
  end
end
