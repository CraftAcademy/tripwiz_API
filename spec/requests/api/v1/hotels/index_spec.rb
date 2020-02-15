# frozen_string_literal: true

RSpec.describe 'GET /api/v1/hotels', type: :request do
  describe 'Hotel suggestions' do
    let(:trip) { create(:trip) }
    3.times do
      let!(:hotel) { create_list(:hotel, 3, trip_id: trip.id) }
    end
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    it '3 hotels succesfully shown' do
      get '/api/v1/hotels',
          params: { trip: trip.id }, headers: headers

      expect(response_json.count).to eq 3
    end
  end
end
