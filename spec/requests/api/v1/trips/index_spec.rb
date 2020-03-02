# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips', type: :request do
  let!(:trip) { create_list(:trip, 4) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Successfully list trips belonging to that user' do
    before do
      get_geobytes_success
      post '/api/v1/trips',
          params: { lat: '59.3293',
                    lng: '18.0685',
                    days: 4}, headers: headers

      get "/api/v1/trips", headers: headers
    end

    it 'and returns a 200 response status' do
      binding.pry
      expect(response).to have_http_status 200
    end

    it 'and returns 1 trip' do
      expect(response_json.length).to eq 1
    end
  end

  describe 'Successfully list all trips when not signed in' do
    before do
      get_geobytes_success
      post '/api/v1/trips',
          params: { lat: '59.3293',
                    lng: '18.0685',
                    days: 4}, headers: headers

      get "/api/v1/trips"
    end

    it 'and returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'and returns 5 trips' do
      expect(response_json.length).to eq 5
    end
  end
end
