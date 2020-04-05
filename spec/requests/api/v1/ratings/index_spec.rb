# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips/:id', type: :request do
  let(:trip) { create(:trip) }
  let(:user) { create(:user) }
  let!(:rating) { create(:rating, trip_id: trip.id, user_id: user.id) }
  let(:trip2) { create(:trip) }
  let(:user2) { create(:user) }
  let!(:rating2) { create(:rating, trip_id: trip2.id, user_id: user2.id, destination_rating: nil) }

  describe 'Succesfully sends index of ratings' do
    before do
      get "/api/v1/ratings"
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns ratings' do
      expect(response_json['destination_rating']).to eq 4
    end
  end

  describe 'Succesfully show ratings when all isnt rated' do
    before do
      get "/api/v1/ratings/#{trip2.id}"
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns incompleted ratings as well' do
      expect(response_json['destination_rating']).to eq nil
    end
  end
end
