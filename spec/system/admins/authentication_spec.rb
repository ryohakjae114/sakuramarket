require 'rails_helper'

RSpec.describe '管理者認証' do
  let!(:admin) { create(:admin) }

  it 'ログインできること' do
    visit new_admin_session_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: '12341234'
    find('input[type="submit"]').click
    expect(page).to have_content 'ログインしました。'
  end

  it 'ログアウトできること' do
    sign_in admin
    visit admins_root_path
    click_button 'ログアウト'
    expect(page).to have_content('ログアウトしました。')
  end
end
