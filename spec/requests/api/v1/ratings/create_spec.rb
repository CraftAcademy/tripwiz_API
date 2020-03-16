# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trips', type: :request do
  let(:user) { create(:user) }
  let(:trip) { create(:trip) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully rating for trip' do
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id,
                     destination_rating: 4,
                     activities_rating: 4,
                     restaurants_rating: 4,
                     hotel_rating: 4 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Cannot rate a trip twice' do
    let!(:rating) do
      create(:rating, trip_id: trip.id, user_id: user.id,
                      destination_rating: 4,
                      activities_rating: nil,
                      restaurants_rating: nil,
                      hotel_rating: nil)
    end
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id,
                     destination_rating: 4 }, headers: headers
    end

    it 'returns a 403 response status' do
      expect(response).to have_http_status 403
    end

    it 'returns the posted rating' do
      expect(response_json['error']).to eq 'Trip already rated, please update'
    end
  end

  describe 'Succesfully rating part of trip' do
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id,
                     destination_rating: 4,
                     restaurants_rating: 4,
                     hotel_rating: 4 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
