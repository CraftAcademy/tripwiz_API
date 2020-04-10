# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips/:id', type: :request do
  let(:trip) { create(:trip) }
  let(:user) { create(:user) }
  let!(:rating) { create(:rating, trip_id: trip.id, user_id: user.id) }
  let(:trip2) { create(:trip, destination: "Prague") }
  let(:trip3) { create(:trip, destination: "St Petersburg") }
  let(:user2) { create(:user) }
  let!(:rating2) { create(:rating, trip_id: trip2.id, user_id: user2.id, destination_rating: 2) }
  let!(:rating3) { create(:rating, trip_id: trip3.id, user_id: user2.id, destination_rating: 1) }
  let!(:activity_type) { create(:activity_type, trip_id: trip.id ) }
  let!(:activity_type2) { create(:activity_type, trip_id: trip2.id ) }
  let!(:activity_type3) { create(:activity_type, trip_id: trip3.id ) }
  let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }

  describe 'Succesfully sends index of ratings' do
    before do
      get "/api/v1/ratings"
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns destination' do
      expect(response_json["destination"][0]["destination"]).to eq "Stockholm"
    end

    it 'returns three ratings for destination' do
      expect(response_json["destination"].length).to eq 3
    end

  end
end
