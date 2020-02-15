# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips', type: :request do
  let!(:trip) { create_list(:trip, 3) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully lists trip information' do
    before do
      get "/api/v1/trips", headers: headers
    end

    it 'and returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'and returns 3 trips' do
      expect(response_json.length).to eq 3
    end
  end
end
