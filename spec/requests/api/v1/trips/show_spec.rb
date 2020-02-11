# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips', type: :request do
  let!(:trip) { create(:trip) }
  3.times do
    let!(:hotel) { create_list(:hotel, 3, trip_id: trip.id) }
  end
  let!(:activity_type) { create(:activity_type, trip_id: trip.id) }
  let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }

  describe 'Succesfully show trip page' do
    before do
      get "/api/v1/trips/#{trip.id}"
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns trip info' do
      expect(response_json['trip']['destination']).to eq trip.destination
    end

    it 'returns activities' do
      expect(response_json['activity']['museum'][0]['name']).to eq 'Museum'
    end

    it 'returns hotels' do
      expect(response_json['hotels'][0]['name']).to eq 'Grand Hotel Stockholm'
    end
  end
end
