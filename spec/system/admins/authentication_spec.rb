require 'rails_helper'
require 'spec_helper'

RSpec.describe '管理者認証' do
  let(:admin) { create(:admin) }

  it 'ログインできること' do
    visit new_admin_session_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: '12341234'
    expect do
      find('input[type="submit"]').click
      expect(current_path).to eq admins_root_path
      expect('page').to have_content 'ログインしました。'
    end
  end

  it 'ログアウトできること' do
    sign_in admin
    visit admins_root_path
    expect do
      click 'ログアウト'
      click 'OK'
      visit admins_food_path
      expect('page').to eq new_admin_session_path
    end
  end
end
