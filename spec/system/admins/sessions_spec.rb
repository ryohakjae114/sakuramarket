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
      expect('page').to have_content 'ログインしました。'
    end
  end
end
