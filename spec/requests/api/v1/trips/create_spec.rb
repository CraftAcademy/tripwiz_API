# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trips', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully adds coords for destination' do
    before do
      get_geobytes_success

      post '/api/v1/trips',
          params: { lat: '59.3293',
                    lng: '18.0685',
                    days: 4 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully when missing coords' do
    before do
      get_geobytes_no_lat_lng

      post '/api/v1/trips',
      params: { days: 4 }, headers: headers
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json['error']).to eq ["Lat can't be blank", "Lng can't be blank"]
    end
  end

  describe 'Unsuccesfully when no city is nearby' do
    before do
      get_geobytes_no_city_nearby
      
      post '/api/v1/trips',
      params: { lat: '9.3293',
                lng: '18.0685',
                days: 4 }, headers: headers
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json['error']).to eq ["Destination can't be blank"]
    end
  end

  describe 'Unsuccesfully when missing days' do
    before do
      get_geobytes_success
      
      post '/api/v1/trips',
      params: { lat: '59.3293',
                lng: '18.0685' }, headers: headers
    end


    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json['error']).to eq ["Days can't be blank"]
    end
  end
end
