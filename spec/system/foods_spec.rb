require 'rails_helper'

RSpec.describe '商品' do
  describe '商品一覧' do
    let!(:food) { create(:food) }

    it '商品一覧画面を閲覧できること' do
      visit foods_path
      expect(page).to have_css('.card')
    end
  end

  describe '商品詳細' do
    let(:food) { create(:food) }

    it '商品詳細情報を閲覧できること' do
      visit food_path(:food)
      expect(page).to have_content('商品詳細画面')
    end
  end
end
