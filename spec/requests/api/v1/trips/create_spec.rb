# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trips', type: :request do
  describe 'Succesfully adds coords for destination' do
    before do
      get_geobytes_success

      post '/api/v1/trips',
           params: { lat: '59.3293',
                     lng: '18.0685' }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully when missing coords' do
    before do
      get_geobytes_no_lat_lng

      post '/api/v1/trips'
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
                     lng: '18.0685' }
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json['error']).to eq ["Destination can't be blank"]
    end
  end
end
