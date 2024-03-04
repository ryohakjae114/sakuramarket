require 'rails_helper'

RSpec.describe "Admins::Foods", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/admins/foods/new"
      expect(response).to have_http_status(:success)
    end
  end

end
