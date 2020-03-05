# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips/:id', type: :request do
  let(:trip) { create(:trip) }
  let(:user) { create(:user) }
  let!(:rating) { create(:rating, trip_id: trip.id, user_id: user.id) }

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
end
