require 'rails_helper'

describe "Home", type: :request do

    let(:url) { "/admin/v1/home" }
    let(:user) { create(:user) }

    it 'Test home' do
      get url, headers: auth_header(user)
      expect(body_json).to eq({'message' => 'Uhul!'})
    end

    it 'Teste home status code' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)  
    end     
end
