require 'rails_helper'

RSpec.describe 'ユーザ認証' do
  describe 'アカウント作成' do
    it 'アカウント作成できること' do
      visit new_user_registration_path
      fill_in 'Eメール', with: 'test@example.com'
      fill_in '姓', with: 'はっつ'
      fill_in '名', with: 'ぁん'
      fill_in '住所', with: '川崎市××区××町3-3-3'
      fill_in 'user_password', with: '12341234'
      fill_in 'user_password_confirmation', with: '12341234'
      click_button 'アカウント作成'
      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end

  describe 'ログイン' do
    let!(:user) { create(:user) }
    it 'ログインできること' do
      visit new_user_session_path
      fill_in 'Eメール', with: 'test@example.com'
      fill_in 'パスワード', with: '12341234'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }
    it 'ログアウトできること' do
      sign_in user
      visit root_path
      click_button 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  describe 'アカウント編集' do
    let!(:user) { create(:user) }
    it 'アカウント編集画面を閲覧できること' do
      sign_in user
      visit edit_user_registration_path
      expect(page).to have_content 'アカウント編集'
    end
  end
end
