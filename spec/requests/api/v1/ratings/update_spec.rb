# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips/:id', type: :request do
  let(:user) { create(:user) }
  let(:trip) { create(:trip) }
  let!(:rating) { create(:rating, trip_id: trip.id, user_id: user.id) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:user2) { create(:user) }
  let(:credentials2) { user2.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }

  describe 'Succesfully updates ratings' do
    before do
      put "/api/v1/ratings/#{trip.id}",
          params: { trip: trip.id,
                    destination_rating: 3,
                    activities_rating: 3,
                    restaurants_rating: 3,
                    hotel_rating: 3 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns updated ratings' do
      expect(response_json['destination_rating']).to eq 3
    end
  end

  describe 'Succesfully updates one rating' do
    before do
      put "/api/v1/ratings/#{trip.id}",
          params: { trip: trip.id,
                    hotel_rating: 3 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns updated rating' do
      expect(response_json['hotel_rating']).to eq 3
    end

    it 'returns updated ratings' do
      expect(response_json['destination_rating']).to eq 4
    end
  end

  describe 'Can only update its own ratings' do
    before do
      put "/api/v1/ratings/#{trip.id}",
          params: { trip: trip.id,
                    hotel_rating: 3 }, headers: headers2
    end

    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end
  end
end
